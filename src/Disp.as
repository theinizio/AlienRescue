package 
{
import flash.display.Sprite;
import flash.text.TextField;

/**
 * ...
 * @author Potapenkov
 */
public class  Disp extends Sprite{
public function Disp():void {
graphics.beginFill(0xeedd89);
/*
var a31:TextField = new TextField(); a31.text = "31; a31.x = 72; a31.y = 390; addChild(a31);
var a32:TextField = new TextField(); a32.text = "32"; a32.x = 174; a32.y = 441; addChild(a32);
var a33:TextField = new TextField(); a33.text = "33"; a33.x = 258; a33.y = 405; addChild(a33);
var a34:TextField = new TextField(); a34.text = "34"; a34.x = 381; a34.y = 405; addChild(a34);
var a35:TextField = new TextField(); a35.text = "35"  ; a35.x = 510; a35.y = 417; addChild(a35);
var a36:TextField = new TextField(); a36.text = "36"; a36.x = 54; a36.y = 297; addChild(a36);
var a37:TextField = new TextField(); a37.text = "37"; a37.x = 459; a37.y = 306; addChild(a37);
var a38:TextField = new TextField(); a38.text = "38"; a38.x = 258; a38.y = 303; addChild(a38);
var a39:TextField = new TextField(); a39.text = "39"; a39.x = 369; a39.y = 312; addChild(a39);
var a40:TextField = new TextField(); a40.text = "40"; a40.x = 471; a40.y = 306; addChild(a40);
var a41:TextField = new TextField(); a41.text = "41"; a41.x = 573; a41.y = 318; addChild(a41);
var a42:TextField = new TextField(); a42.text = "42"; a42.x = 54; a42.y = 183; addChild(a42);
var a43:TextField = new TextField(); a43.text = "43"; a43.x = 150; a43.y = 174; addChild(a43);
var a44:TextField = new TextField(); a44.text = "44"; a44.x = 246; a44.y = 180; addChild(a44);
var a45:TextField = new TextField(); a45.text = "45"; a45.x = 342; a45.y = 180; addChild(a45);
var a46:TextField = new TextField(); a46.text = "46"; a46.x = 456; a46.y = 180; addChild(a46);
var a47:TextField = new TextField(); a47.text = "47"; a47.x = 564; a47.y = 177; addChild(a47);
var a48:TextField = new TextField(); a48.text = "48"; a48.x = 66; a48.y = 75; addChild(a48);
var a49:TextField = new TextField(); a49.text = "49"; a49.x = 156; a49.y = 78; addChild(a49);
var a50:TextField = new TextField(); a50.text = "50"; a50.x = 249; a50.y = 63; addChild(a50);
var a51:TextField = new TextField(); a51.text = "51"; a51.x = 354; a51.y = 69; addChild(a51);
var a52:TextField = new TextField(); a52.text = "52"; a52.x = 459; a52.y = 72; addChild(a52);
var a53:TextField = new TextField(); a53.text = "53"; a53.x = 558; a53.y = 81; addChild(a53);
var a54:TextField = new TextField(); a54.text = "54"; a54.x = 45; a54.y = -99; addChild(a54);
var a55:TextField = new TextField(); a55.text = "55"; a55.x = 126; a55.y = -42; addChild(a55);
var a56:TextField = new TextField(); a56.text = "56"; a56.x = 216; a56.y = -60; addChild(a56);
var a57:TextField = new TextField(); a57.text = "57"; a57.x = 318; a57.y = -57; addChild(a57);
var a58:TextField = new TextField(); a58.text = "58"; a58.x = 408; a58.y = -81; addChild(a58);
var a59:TextField = new TextField(); a59.text = "59"; a59.x = 501; a59.y = -81; addChild(a59);
var a60:TextField = new TextField(); a60.text = "60"; a60.x = 576; a60.y = -45; addChild(a60);
*/
var a31:TextField = new TextField(); a31.text = "31"; a31.x = 72; a31.y = 528; addChild(a31);
var a32:TextField = new TextField(); a32.text = "32"; a32.x = 174; a32.y = 579; addChild(a32);
var a33:TextField = new TextField(); a33.text = "33"; a33.x = 258; a33.y = 543; addChild(a33);
var a34:TextField = new TextField(); a34.text = "34"; a34.x = 381; a34.y = 546; addChild(a34);
var a35:TextField = new TextField(); a35.text = "35"; a35.x = 510; a35.y = 555; addChild(a35);
var a36:TextField = new TextField(); a36.text = "36"; a36.x = 54; a36.y = 435; addChild(a36);
var a37:TextField = new TextField(); a37.text = "37"; a37.x = 459; a37.y = 444; addChild(a37);
var a38:TextField = new TextField(); a38.text = "38"; a38.x = 258; a38.y = 441; addChild(a38);
var a39:TextField = new TextField(); a39.text = "39"; a39.x = 369; a39.y = 450; addChild(a39);
var a40:TextField = new TextField(); a40.text = "40"; a40.x = 471; a40.y = 444; addChild(a40);
var a41:TextField = new TextField(); a41.text = "41"; a41.x = 573; a41.y = 456; addChild(a41);
var a42:TextField = new TextField(); a42.text = "42"; a42.x = 54; a42.y = 321; addChild(a42);
var a43:TextField = new TextField(); a43.text = "43"; a43.x = 150; a43.y = 312; addChild(a43);
var a44:TextField = new TextField(); a44.text = "44"; a44.x = 246; a44.y = 318; addChild(a44);
var a45:TextField = new TextField(); a45.text = "45"; a45.x = 342; a45.y = 318; addChild(a45);
var a46:TextField = new TextField(); a46.text = "46"; a46.x = 456; a46.y = 318; addChild(a46);
var a47:TextField = new TextField(); a47.text = "47"; a47.x = 564; a47.y = 315; addChild(a47);
var a48:TextField = new TextField(); a48.text = "48"; a48.x = 66; a48.y = 213; addChild(a48);
var a49:TextField = new TextField(); a49.text = "49"; a49.x = 156; a49.y = 216; addChild(a49);
var a50:TextField = new TextField(); a50.text = "50"; a50.x = 249; a50.y = 201; addChild(a50);
var a51:TextField = new TextField(); a51.text = "51"; a51.x = 354; a51.y = 207; addChild(a51);
var a52:TextField = new TextField(); a52.text = "52"; a52.x = 459; a52.y = 213; addChild(a52);
var a53:TextField = new TextField(); a53.text = "53"; a53.x = 558; a53.y = 219; addChild(a53);
var a54:TextField = new TextField(); a54.text = "54"; a54.x = 45; a54.y = 39; addChild(a54);
var a55:TextField = new TextField(); a55.text = "55"; a55.x = 126; a55.y = 96; addChild(a55);
var a56:TextField = new TextField(); a56.text = "56"; a56.x = 216; a56.y = 78; addChild(a56);
var a57:TextField = new TextField(); a57.text = "57"; a57.x = 318; a57.y = 81; addChild(a57);
var a58:TextField = new TextField(); a58.text = "58"; a58.x = 408; a58.y = 57; addChild(a58);
var a59:TextField = new TextField(); a59.text = "59"; a59.x = 501; a59.y = 57; addChild(a59);
var a60:TextField = new TextField(); a60.text = "60"; a60.x = 576; a60.y = 93; addChild(a60);

}
}

}