package spill.localisation
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.*;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * This component manages the placing text within the supplied rectangular 
	 * area so that text does not go outside. Has many properies similar to 
	 * normal textfields.
	 * 
	 * @author Sjoerd Schoneveld
	 */		
	public class TextFieldFit extends MovieClip
	{
		
		private var field:TextField;
		private var w:Number;
		private var h:Number;
		private var format:TextFormat;
		private var embeddedFonts:Array;
		private var sizeChanged:Boolean = true;
		private static const gutter:Number = 2;
		/** @private */	
		spil_internal static var embedFonts:Boolean = true;
		/** @private */	
		spil_internal static var forceFont:String = null;
		/** @private */	
		spil_internal static var forceAAType:String = null;	
		public static var alwaysCheckWidth:Boolean = false;	
		private var debugBounding:Sprite;
		
		/**
		 * Retrieves a reference to the TextField wrapped by the component
		 */
		public function get textField():TextField
		{
			return field;
		}
		
		public function TextFieldFit()
		{
			
			var isLivePreview:Boolean = (parent != null && getQualifiedClassName(parent) == "fl.livepreview::LivePreviewParent");
			
			var _w:Number = width;
			var _h:Number = height;
			
			
			if (numChildren > 0) {
				removeChildAt(0);
			}
			
			if(!field){
				field = new TextField();
				addChild(field);
			}

			field.border = false;
			field.background = false;
			field.type = TextFieldType.DYNAMIC;
			
			mouseEnabled = false;
			mouseChildren = false;
			
			format = new TextFormat();
						
			embeddedFonts = Font.enumerateFonts(false);
			setSize(_w, _h);
			validate();
			

			//visible = false;
			
			//addEventListener(Event.ADDED, initEvent);
			//addEventListener(Event.ADDED_TO_STAGE, initEvent);
			//addEventListener(Event.INIT, initEvent);
			if(stage){
				addEventListener(Event.RENDER, init);
				stage.invalidate();
			}
			init();
		}
		
		private function init(e:Event = null) : void
		{
			removeEventListener(Event.RENDER, init);
			updateProperties();
			layoutText();
			
		}
		

		//public static function set embedFonts(value:Boolean) : void
		//{
		//	embed = value;
		//}
				
		protected function updateProperties() : void
		{
			// Text Field basics
			field.text = _text;
			field.multiline = (_text.indexOf(" ") < 0 && _text.length < 14) ? false : _multiline; // Disable multiline on single words
			field.wordWrap = field.multiline && !_disableWordwrap;
			field.selectable = _selectable;
			field.antiAliasType = forceAAType ? forceAAType : _antiAliasType;
			field.gridFitType = _gridFitType;

			embeddedFonts = Font.enumerateFonts(false);
			// manage embedding
			if (_embedFonts && _font != "" && TextFieldFit.embedFonts) {
				var hasFont:Boolean = false;
				for each(var f:Font in embeddedFonts) {
					if (_font == f.fontName) {
						hasFont = true;
						break;
					}
				}
				field.embedFonts = hasFont;
				if (!hasFont) {
					trace("WARNING: Embedded font '" + _font + "' not found, disabling embedding of fonts, text = " + _text);
				} else {
					trace("Found Embedded font '" + _font + "' using font");
				}
			} else { 
				
				field.embedFonts = false;
			}
			
			
				//field.embedFonts = false;
				
			// Text Formatting
			if(TextFieldFit.forceFont){
				format.font = TextFieldFit.forceFont;
			} else {
				format.font = _font;	
			}
			if(sizeChanged) format.size = _textSize;
			format.color = _textColor;
			format.align = _hAlign;
			format.bold = _bold;
			format.italic = _italic;
			format.underline = _underline;
			format.leftMargin = 0;
			format.rightMargin = 0;		
			field.setTextFormat(format);
			//field.
			
			// Glow Filter
			
			if (_useGlowFilter) {
				filters = [new GlowFilter(_glowColor, 1, _glowBlur, _glowBlur, _glowStrength, _glowQuality)];
			} else {
				filters = [];
			}
			
			
		}
		
		
		//private function 
		
		public function setSize(_w:Number, _h:Number) : void
		{
			w = _w;
			h = _h;
			scaleX = scaleY = 1;
			field.width = w;
			field.height = h;
			invalidate();
			//debugBounding.width = w;
			//debugBounding.height = h;
		}
		
		private function layoutText() : void
		{
			resizeText();
			field.height = field.textHeight + gutter * 2;
			if (vAlign == "top") {
				field.y = 0;
			} else if (vAlign == "middle") {
				field.y = (h - field.height) / 2;
			} else if (vAlign == "bottom") {
				field.y = h - field.height;
			}
		}
		
		private function resizeText(c:Boolean = false) : void
		{
			if (!doesTextFit()) {
				
				format.size = Object(Number(format.size) - 1);
				if (format.size <= 3) {
					trace("WARNING: Text resised to 3px, either an error occured or the text just wont fit");
					return;
				}
				field.setTextFormat(format);
				resizeText(true);
			
			} else if(c == false){
				while (doesTextFit()) {
					if(format.size <= textSize){
						format.size = Object(Number(format.size) + 1);
						field.setTextFormat(format);
						if (!doesTextFit()) {
							format.size = Object(Number(format.size) - 1);
							field.setTextFormat(format);
							break;
						}
					} else {
						break;
					}
				}
				
			}
			
		}
	
		private function doesTextFit() : Boolean
		{
			
			if (field.textHeight + gutter * 2 > h || 
				(field.textWidth + gutter * 2 > w && (!field.multiline || alwaysCheckWidth))) {
				return false;
			}
			return true;
			
		}
		
		
		private var valid:Boolean = true;
		private function invalidate():void
		{
			if (valid) {
				addEventListener(Event.ENTER_FRAME, validate);
				if(stage)stage.invalidate();
				valid = false;
			}
		}
		
		private function validate(e:Event = null):void
		{
			//if(this.parent){
			//	trace("validate parent = " + this.parent + " name = " + this.parent.name + " text = " + text);
			//}
			
			//visible = true;
			updateProperties();
			layoutText();
			removeEventListener(Event.ENTER_FRAME, validate);
			valid = true;
		}
		
		
		/*
		public function set componentInspectorSetting(value:Boolean) : void
		{
			//trace("set componentInspectorSetting = " + value);
			if(!value){
				validate();
			}
		}
		*/
		
		//================================================================
		// Text
		//================================================================
		/** @private */
		protected var _text:String = "default";  
		[Inspectable (name="  Text", defaultValue="Text")]
		public function set text(value:String):void
		{
			_text = value;
			invalidate();
		}
		public function get text():String
		{
			return _text;
		}
		
		//================================================================
		// Text Color
		//================================================================
		/** @private */	
		protected var _textColor:uint = 0x000000;  
		[Inspectable (name="  Text Color", type="Color")]
		public function set textColor(value:uint):void
		{
			_textColor = value;
			invalidate();
		}
		public function get textColor():uint
		{
			return _textColor
		} 
	
		
		//================================================================
		// Text Size
		//================================================================
		/** @private */	
		protected var _textSize:Number = 12;  
		[Inspectable (name="  Text Size", defaultValue="12")]
		public function set textSize(value:Number):void
		{
			_textSize = value;
			sizeChanged = true;
			invalidate();
		}
		public function get textSize():Number
		{
			return _textSize
		} 
		
		
		//================================================================
		// Multi Line
		//================================================================
		/** @private */	
		protected var _multiline:Boolean = false;  
		[Inspectable (name=" Multi Line", defaultValue="false")]
		public function set multiline(value:Boolean):void
		{
			_multiline= value;
			invalidate();
		}
		public function get multiline():Boolean
		{
			return _multiline
		} 
		
		//================================================================
		// Disable Wordwrap
		//================================================================
		/** @private */	
		protected var _disableWordwrap:Boolean = false;  
		[Inspectable (name=" Disable Wordwrap", defaultValue="false")]
		public function set disableWordwrap(value:Boolean):void
		{
			_disableWordwrap = value;
			invalidate();
		}
		public function get disableWordwrap():Boolean
		{
			return _disableWordwrap
		} 
				
		//================================================================
		// Horizontal Align
		//================================================================
		/** @private */	
		protected var _hAlign:String = "left";  
		[Inspectable (name=" Horizontal Align", type="list", enumeration="left, center, right", defaultValue="left")]
		public function set hAlign(value:String):void
		{
			_hAlign= value;
			invalidate();
		}
		public function get hAlign():String
		{
			return _hAlign
		} 
		
		//================================================================
		// Vertical Align
		//================================================================
		/** @private */	
		protected var _vAlign:String = "top";  
		[Inspectable (name=" Vertical Align", type="list", enumeration="top, middle, bottom",  defaultValue="top")]
		public function set vAlign(value:String):void
		{
			_vAlign= value;
			invalidate();
		}
		public function get vAlign():String
		{
			return _vAlign
		} 
		
		//================================================================
		// Bold
		//================================================================
		/** @private */	
		protected var _bold:Boolean = false;
		[Inspectable (name=" Bold", defaultValue = "false")]
		public function set bold(value:Boolean):void
		{
			_bold = value;
			invalidate();
		}
		public function get bold():Boolean
		{
			return _bold;
		}
		
		//================================================================
		// Underline
		//================================================================
		/** @private */	
		protected var _underline:Boolean = false;
		[Inspectable (name = "Underline", defaultValue = "false")]
		public function set underline(value:Boolean):void
		{
			_underline = value;
			invalidate();
		}
		public function get underline():Boolean 
		{
			return _underline;
		}
		
		//================================================================
		// Italic
		//================================================================
		/** @private */	
		protected var _italic:Boolean = false;
		[Inspectable (name = "Italic", defaultValue = "false")]
		public function set italic(value:Boolean):void
		{
			_italic = value;
			invalidate();
		}
		public function get italic():Boolean 
		{
			return _italic
		}
		
		
		//================================================================
		// Selectable
		//================================================================
		/** @private */	
		protected var _selectable:Boolean = false;
		[Inspectable (name = "Selectable", defaultValue = "false")]
		public function set selectable(value:Boolean):void
		{
			_selectable = value;
			invalidate();
		}
		public function get selectable():Boolean 
		{
			return _selectable
		}
		
		//================================================================
		// Custom Font
		//================================================================
		/** @private */	
		protected var _font:String = "";
		[Inspectable (name = " Font", defaultValue = "")]
		public function set font(value:String):void
		{
			_font = value;
			invalidate();
		}
		public function get font():String 
		{
			return _font;
		}
		
		//================================================================
		// Embed Font
		//================================================================
		/** @private */	
		protected var _embedFonts:Boolean = true;
		[Inspectable (name = " Embed Fonts", defaultValue = "true")]
		public function set embedFonts(value:Boolean):void
		{
			_embedFonts = value;
			invalidate();
		}
		public function get embedFonts():Boolean 
		{
			return _embedFonts;
		}
		
		//================================================================
		// Anti Alias Type
		//================================================================
		/** @private */	
		protected var _antiAliasType:String = "advanced";
		[Inspectable (name = "Anti Alias Type",enumeration="normal, advanced", defaultValue = "advanced")]
		public function set antiAliasType(value:String):void
		{
			_antiAliasType = value;
			invalidate();
		}
		public function get antiAliasType():String 
		{
			return _antiAliasType;
		}
		
		//================================================================
		// Grid Fit Type
		//================================================================
		/** @private */	
		protected var _gridFitType:String = "pixel";
		[Inspectable (name = "Grid Fit Type", enumeration="none, pixel, subpixel", defaultValue = "pixel")]
		public function set gridFitType(value:String):void
		{
			_gridFitType = value;
			invalidate();
		}
		public function get gridFitType():String 
		{
			return _gridFitType;
		}
		
		//================================================================
		// Glow Filter
		//================================================================
		/** @private */	
		protected var _useGlowFilter:Boolean = false;
		[Inspectable (name = "Glow Filter", defaultValue = "false")]
		public function set useGlowFilter(value:Boolean):void
		{
			_useGlowFilter = value;
			invalidate();
		}
		public function get useGlowFilter():Boolean 
		{
			return _useGlowFilter;
		}
		
		//================================================================
		// Glow Blur
		//================================================================
		/** @private */	
		protected var _glowBlur:Number = 3;  
		[Inspectable (name="Glow Blur", defaultValue="3")]
		public function set glowBlur(value:Number):void
		{
			_glowBlur = value;
			invalidate();
		}
		public function get glowBlur():Number
		{
			return _glowBlur
		} 

		//================================================================
		// Glow Color
		//================================================================
		/** @private */	
		protected var _glowColor:uint = 0x000000;  
		[Inspectable (name="Glow Color", type="Color")]
		public function set glowColor(value:uint):void
		{
			_glowColor = value;
			invalidate();
		}
		public function get glowColor():uint
		{
			return _glowColor
		} 
		
		//================================================================
		// Glow Strength
		//================================================================
		/** @private */
		protected var _glowStrength:Number = 5;  
		[Inspectable (name="Glow Strength", type="Number", defaultValue="5")]
		public function set glowStrength(value:Number):void
		{
			_glowStrength = value;
			invalidate();
		}
		public function get glowStrength():Number
		{
			return _glowStrength
		} 
		
		//================================================================
		// Glow Quality
		//================================================================
		/** @private */	
		protected var _glowQuality:Number = 1;  
		[Inspectable (name="Glow Quality", type="Number", defaultValue="1")]
		public function set glowQuality(value:Number):void
		{
			_glowQuality = value;
			invalidate();
		}
		public function get glowQuality():Number
		{
			return _glowQuality
		} 
			
	}
	
}