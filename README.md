# Sign-Language-System

**User guide**

To run the sign language interpretation system, you must have Processing installed on your machine. Processing can be found at the location: https://processing.org/download/

You must also have the video library (processing.video.*) and the openCV library (gab.opencv.*) installed, which can be found at https://github.com/atduskgreg/opencv-processing.

A detailed account of how to install a library in Processing can be found here: https://github.com/processing/processing/wiki/How-to-Install-a-Contributed-Library

To run the sign language interpretation system, you must have a glove which has strategically placed coloured dots on the fingertips, as well as one coloured dot on the index finger knuckle, and one coloured dot on the pinkie finger knuckle. You are free to choose the colour, however you must enter the new colour into the code, and you must only use one colour. Try to avoid red hues, as human skin contains a significant amount of red and will create undesirable noise. Green dots are best. An example image is given below:
The system will track the coloured dots in real time. Presently, the system is able to detect eight symbols, these include:

1. The number one, two, three, four, and five, by determining how many fingers are held up.
2. The sign for peace, which is symbolised by holding up the index and middle finger.
3. The sign for good, which is symbolised by holding a “thumbs up”.
4. The sign for surf’s up, which is symbolised by holding out the pinkie and thumb.

Two screens are displayed. The left screen will display the video in real time, and should be used for guidance and symbol detection. The screen on the right shows the thresholded down version of the detected colours, and should be used to determine whether or not the colours are being adequately detected. If they are not, try moving to a room with better lighting as the responsiveness of the system is sensitive to the lighting conditions.

**Author**

Ryan Michael Thomas
