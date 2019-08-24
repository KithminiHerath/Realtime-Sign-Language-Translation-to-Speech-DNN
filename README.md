# Realtime-Sign-Language-Translation-to-Speech-DNN
This project is carried out for the InnovateFPGA 2019 competition as regional finalists in the AciaPacific region. Our project
details are available [here](http://www.innovatefpga.com/cgi-bin/innovate/teams.pl?Id=AP047).

Our project consists of three main sections and they are;
* Training a Deep Neural Network(DNN) to classify atleast 5 sign language gestures.
* Inferencing of the DNN and fusion of sensors using the DE10-Nano FPGA board
* Interfacing of external devices with the DE10-Nano FPGA board

Before training a DNN for sign language translation - for sign language gesture classification the process started by identifying a few features to train a Support Vector Classifier to do the classification using 
the American Sign Language(ASL) examples in this dataset available at the following [website](https://data.mendeley.com/datasets/wgswcr8z24/2).
We are planning to use Intel openCL SDK for FPGA to implement the system in the FPGA board.
