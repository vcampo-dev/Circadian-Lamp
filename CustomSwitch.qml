import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Switch {

    id: control

    indicator: Rectangle
    {
     implicitHeight: 32
     implicitWidth: 56
     x:control.leftPadding
     y:parent.height/2-height/2
     radius: width/2
     color: control.checked ? "#ee5253" : "#222f3e"
     border.width: control.checked ? 2:1
     border.color: control.checked ? "#1dd1a1":"#ee5253"

     Rectangle
     {
      x: control.checked ? (parent.width-width)-2:2
      width: 28
      height: 28
      radius: height/2
      color: control.checked ? "#FFFFFF":"#7a859b"
      anchors.verticalCenter:parent.verticalCenter
     }

    }

    contentItem: Label
    {
     text: control.text
     //font.pixelSize: FontStyle.h3
     verticalAlignment: Text.AlignVCenter
     leftPadding: control.indicator.width + control.spacing
    }

}
