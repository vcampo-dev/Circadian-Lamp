import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 2.15
import TFG_lamp

ApplicationWindow {
    visible: true
    width: 640;
    height: 480;
    title: qsTr("Circadian Lamp")

    MqttClient
    {
      id: client
      hostname: "test.mosquitto.org"
      port: 1883
    }

    JsonForQml
    {
     id: myclass
    }

    Timer
    {
        interval: 2000
        repeat:true
        running: true
        onTriggered:
        {
            myclass.modify_json("Mode",auto_man.position)
            myclass.modify_json("ON_OFF",on_off.position)
            myclass.modify_json("I_White",myslider_white.value)
            myclass.modify_json("I_Yellow",myslider_yellow.value)
            client.publish("Pruebas_TFG", myclass.send_json(), 0, true)
        }
    }

    ListView{
    anchors.fill: parent
    id: mylistview
    spacing: 5
    model: ListModel{
       ListElement{
           mytext: "UNIOVI TFG Project"
       }
    }
    delegate: Rectangle {
        width: parent.width
        height: 60
        Text{
          text: mytext
          anchors.centerIn: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          wrapMode: Text.WrapAtWordBoundaryOrAnywhere
          color: 'white'
        }
        color: 'green'
        border.color: 'red'
        border.width: 2
    }
    }

    ColumnLayout
    {
     spacing: 20
     anchors.centerIn: parent

     Row
     {
         CustomSwitch
         {id:mio
          text: client.state === MqttClient.Connected ? "Conectado" : "Desconectado"
          enabled: true
          onPositionChanged:
          { if(client.state === MqttClient.Connected)
              {
                  myclass.initialice_json()
                  client.publish("Pruebas_TFG", myclass.send_json(), 0, true)
                  client.disconnectFromHost()
              }
            else
               client.connectToHost();
          }
         }
     }

     Row
     {
         Slider{
         id: myslider_white
         width: 350
         from: 0
         to: 100
         stepSize: 1
         //anchors.centerIn: parent

        background: Rectangle
          {
           x: myslider_white.leftPadding
           y: myslider_white.topPadding +myslider_white.availableHeight/2 - height/2
           implicitWidth: 250
           implicitHeight: 20
           width: myslider_white.availableWidth
           height: implicitHeight
           radius: height/2
           color: "#e0e0e0"

           Rectangle
           {
             width: myslider_white.visualPosition == 0 ? 0 : myslider_white.handle.x + myslider_white.handle.width/2
             height: parent.height
             color: "#1565c0"
             radius: height/2
           }
          }

         handle: Rectangle
         {
          x: myslider_white.leftPadding + myslider_white.visualPosition*(myslider_white.availableWidth-width)
          y: myslider_white.topPadding + myslider_white.availableHeight/2 - height/2
          implicitHeight: 30
          implicitWidth: 20
          radius: implicitWidth/2
          color: myslider_white.pressed ? "#ee5253" : "#222f3e"
          border.color: "#1dd1a1"
          border.width: 1
         }
         Text{
         id: mySliderText
         text: "Intensidad %: " + myslider_white.value
         anchors.top: myslider_white.bottom
         anchors.horizontalCenter: myslider_white.horizontalCenter
         }


         enabled: on_off.position === 1 && auto_man.position === 1 ? true : false

         value: on_off.position === 0 ? 0 : auto_man.position === 0 ? 30 : 30 //donde puse el 30 iría el valor que recibe Mqtt

         }
      }

     Row
     {
         Slider{
         id: myslider_yellow
         width: 350
         from: 0
         to: 100
         stepSize: 1

        background: Rectangle
          {
           x: myslider_yellow.leftPadding
           y: myslider_yellow.topPadding +myslider_yellow.availableHeight/2 - height/2
           implicitWidth: 250
           implicitHeight: 20
           width: myslider_yellow.availableWidth
           height: implicitHeight
           radius: height/2
           color: "#e0e0e0"

           Rectangle
           {
             width: myslider_yellow.visualPosition == 0 ? 0 : myslider_yellow.handle.x + myslider_yellow.handle.width/2
             height: parent.height
             color: "#ff5722"
             radius: height/2
           }
          }

         handle: Rectangle
         {
          x: myslider_yellow.leftPadding + myslider_yellow.visualPosition*(myslider_yellow.availableWidth-width)
          y: myslider_yellow.topPadding + myslider_yellow.availableHeight/2 - height/2
          implicitHeight: 30
          implicitWidth: 20
          radius: implicitWidth/2
          color: myslider_yellow.pressed ? "#ee5253" : "#222f3e"
          border.color: "#1dd1a1"
          border.width: 1
         }
         Text{
         id: mySliderText2
         text: "Intensidad %: " + myslider_yellow.value
         anchors.top: myslider_yellow.bottom
         anchors.horizontalCenter: myslider_yellow.horizontalCenter
         }

         enabled: on_off.position === 1 && auto_man.position === 1 ? true : false

         value: on_off.position === 0 ? 0 : auto_man.position === 0 ? 30 : 30 //donde puse el 30 iría el valor que recibe Mqtt

         //onPositionChanged: myclass.modify_json("I_Yellow",myslider_yellow.value)//client.publish("prueba_TFG", myslider_yellow.value, 0, true)
         }
      }
     RowLayout
     {
      spacing: 100      
      CustomSwitch
      {
          id:on_off
          text: qsTr("ON/OFF")
          enabled: true
      }
      CustomSwitch
      {
       id:auto_man
       text: auto_man.position === 0 ? "Auto" : "Manual"
       enabled: true
       //onPositionChanged:client.publish("prueba_TFG", myslider_yellow.value, 0, true)
      }
     }
    }

}
