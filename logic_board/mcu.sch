EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 4
Title "Microcontroller"
Date "2020-02-08"
Rev "1.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	5300 5350 5300 5450
Wire Wire Line
	5300 5450 5400 5450
Wire Wire Line
	5600 5450 5600 5350
Wire Wire Line
	5500 5350 5500 5450
Connection ~ 5500 5450
Wire Wire Line
	5500 5450 5600 5450
Wire Wire Line
	5500 5600 5500 5450
Wire Wire Line
	5400 5350 5400 5450
Connection ~ 5400 5450
Wire Wire Line
	5400 5450 5500 5450
$Comp
L Device:CP C4
U 1 1 5E2FF651
P 2700 6400
F 0 "C4" H 2818 6446 50  0000 L CNN
F 1 "10uF" H 2818 6355 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 2738 6250 50  0001 C CNN
F 3 "~" H 2700 6400 50  0001 C CNN
	1    2700 6400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 5E2FFF4C
P 3050 6400
F 0 "C5" H 3165 6446 50  0000 L CNN
F 1 "0.1uF" H 3165 6355 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3088 6250 50  0001 C CNN
F 3 "~" H 3050 6400 50  0001 C CNN
	1    3050 6400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C6
U 1 1 5E30073C
P 3350 6400
F 0 "C6" H 3465 6446 50  0000 L CNN
F 1 "0.1uF" H 3465 6355 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3388 6250 50  0001 C CNN
F 3 "~" H 3350 6400 50  0001 C CNN
	1    3350 6400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 5E300B33
P 3700 6400
F 0 "C7" H 3815 6446 50  0000 L CNN
F 1 "0.1uF" H 3815 6355 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3738 6250 50  0001 C CNN
F 3 "~" H 3700 6400 50  0001 C CNN
	1    3700 6400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8
U 1 1 5E301108
P 4050 6400
F 0 "C8" H 4165 6446 50  0000 L CNN
F 1 "0.1uF" H 4165 6355 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4088 6250 50  0001 C CNN
F 3 "~" H 4050 6400 50  0001 C CNN
	1    4050 6400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 6700 4050 6550
Wire Wire Line
	2700 6550 2700 6700
Connection ~ 2700 6700
Wire Wire Line
	2700 6700 3050 6700
Wire Wire Line
	3050 6550 3050 6700
Connection ~ 3050 6700
Wire Wire Line
	3050 6700 3350 6700
Wire Wire Line
	3350 6550 3350 6700
Connection ~ 3350 6700
Wire Wire Line
	3350 6700 3700 6700
Wire Wire Line
	3700 6550 3700 6700
Connection ~ 3700 6700
Wire Wire Line
	3700 6700 4050 6700
Wire Wire Line
	4050 6050 4050 6250
Wire Wire Line
	2700 6250 2700 6050
Connection ~ 2700 6050
Wire Wire Line
	2700 6050 3050 6050
Wire Wire Line
	3050 6250 3050 6050
Connection ~ 3050 6050
Wire Wire Line
	3050 6050 3350 6050
Wire Wire Line
	3350 6250 3350 6050
Connection ~ 3350 6050
Wire Wire Line
	3350 6050 3700 6050
Wire Wire Line
	3700 6250 3700 6050
Connection ~ 3700 6050
Wire Wire Line
	3700 6050 4050 6050
$Comp
L power:GND #PWR02
U 1 1 5E30A581
P 2700 6900
F 0 "#PWR02" H 2700 6650 50  0001 C CNN
F 1 "GND" H 2705 6727 50  0000 C CNN
F 2 "" H 2700 6900 50  0001 C CNN
F 3 "" H 2700 6900 50  0001 C CNN
	1    2700 6900
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR01
U 1 1 5E30AA41
P 2700 5800
F 0 "#PWR01" H 2700 5650 50  0001 C CNN
F 1 "+3V3" H 2715 5973 50  0000 C CNN
F 2 "" H 2700 5800 50  0001 C CNN
F 3 "" H 2700 5800 50  0001 C CNN
	1    2700 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 6050 2700 5800
Wire Wire Line
	2700 6900 2700 6700
$Comp
L power:+3V3 #PWR010
U 1 1 5E40AE38
P 7900 4800
F 0 "#PWR010" H 7900 4650 50  0001 C CNN
F 1 "+3V3" V 7915 4928 50  0000 L CNN
F 2 "" H 7900 4800 50  0001 C CNN
F 3 "" H 7900 4800 50  0001 C CNN
	1    7900 4800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9700 2000 9800 2000
Wire Wire Line
	9700 3100 9800 3100
Wire Wire Line
	9800 3100 9800 3200
Wire Wire Line
	9800 2000 9800 2400
Connection ~ 9800 3100
Wire Wire Line
	9700 2400 9800 2400
Connection ~ 9800 2400
Wire Wire Line
	9800 2400 9800 2750
Wire Wire Line
	9700 2750 9800 2750
Connection ~ 9800 2750
Wire Wire Line
	9800 2750 9800 3100
Text GLabel 6400 4800 2    50   BiDi ~ 0
USB_DP
Text GLabel 6400 4700 2    50   BiDi ~ 0
USB_DM
$Comp
L Switch:SW_Push SW4
U 1 1 5E4374E4
P 9500 3100
F 0 "SW4" H 9500 3385 50  0000 C CNN
F 1 "TL3315NF160Q" H 9500 3294 50  0000 C CNN
F 2 "custom_footprints:TL3315NF160Q_Tactile_Switch" H 9500 3300 50  0001 C CNN
F 3 "http://spec_sheets.e-switch.com/specs/P010337.pdf" H 9500 3300 50  0001 C CNN
F 4 "Switch Effect" H 9850 3200 50  0000 C CNN "Name"
	1    9500 3100
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW1
U 1 1 5E437998
P 9500 2000
F 0 "SW1" H 9500 2285 50  0000 C CNN
F 1 "TL3315NF160Q" H 9500 2194 50  0000 C CNN
F 2 "custom_footprints:TL3315NF160Q_Tactile_Switch" H 9500 2200 50  0001 C CNN
F 3 "http://spec_sheets.e-switch.com/specs/P010337.pdf" H 9500 2200 50  0001 C CNN
F 4 "Volume Down" H 9850 2100 50  0000 C CNN "Name"
	1    9500 2000
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW3
U 1 1 5E436F53
P 9500 2750
F 0 "SW3" H 9500 3035 50  0000 C CNN
F 1 "TL3315NF160Q" H 9500 2944 50  0000 C CNN
F 2 "custom_footprints:TL3315NF160Q_Tactile_Switch" H 9500 2950 50  0001 C CNN
F 3 "http://spec_sheets.e-switch.com/specs/P010337.pdf" H 9500 2950 50  0001 C CNN
F 4 "Metronome" H 9800 2800 50  0000 C CNN "Name"
	1    9500 2750
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 5E43625B
P 9500 2400
F 0 "SW2" H 9500 2685 50  0000 C CNN
F 1 "TL3315NF160Q" H 9500 2594 50  0000 C CNN
F 2 "custom_footprints:TL3315NF160Q_Tactile_Switch" H 9500 2600 50  0001 C CNN
F 3 "http://spec_sheets.e-switch.com/specs/P010337.pdf" H 9500 2600 50  0001 C CNN
F 4 "Volume Up" H 9900 2500 50  0000 C CNN "Field4"
	1    9500 2400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5E31F2DC
P 9800 3200
F 0 "#PWR0101" H 9800 2950 50  0001 C CNN
F 1 "GND" H 9805 3027 50  0000 C CNN
F 2 "" H 9800 3200 50  0001 C CNN
F 3 "" H 9800 3200 50  0001 C CNN
	1    9800 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 1850 5600 1550
$Comp
L power:+3V3 #PWR07
U 1 1 5E2ABB90
P 5600 1550
F 0 "#PWR07" H 5600 1400 50  0001 C CNN
F 1 "+3V3" H 5615 1723 50  0000 C CNN
F 2 "" H 5600 1550 50  0001 C CNN
F 3 "" H 5600 1550 50  0001 C CNN
	1    5600 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 1850 5700 1850
Connection ~ 5600 1850
Wire Wire Line
	5600 2200 5600 1850
Wire Wire Line
	5500 1850 5600 1850
Connection ~ 5500 1850
Wire Wire Line
	5500 2200 5500 1850
Wire Wire Line
	5700 1850 5700 2200
Wire Wire Line
	5400 1850 5500 1850
Wire Wire Line
	5400 2200 5400 1850
Wire Wire Line
	3950 3100 3950 3050
$Comp
L power:GND #PWR03
U 1 1 5E41D25E
P 3950 3100
F 0 "#PWR03" H 3950 2850 50  0001 C CNN
F 1 "GND" H 3955 2927 50  0000 C CNN
F 2 "" H 3950 3100 50  0001 C CNN
F 3 "" H 3950 3100 50  0001 C CNN
	1    3950 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 2850 3800 2850
Wire Wire Line
	3750 2750 3750 2850
$Comp
L Device:Resonator Y1
U 1 1 5E41265A
P 3950 2850
F 0 "Y1" H 3950 3100 50  0000 C CNN
F 1 "8 MHz" H 3950 3000 50  0000 C CNN
F 2 "custom_footprints:AWSCR-8.00CPLB-C30-T4" H 3925 2850 50  0001 C CNN
F 3 "~" H 3925 2850 50  0001 C CNN
	1    3950 2850
	-1   0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR04
U 1 1 5E40F10E
P 4700 2550
F 0 "#PWR04" H 4700 2400 50  0001 C CNN
F 1 "+3V3" V 4715 2678 50  0000 L CNN
F 2 "" H 4700 2550 50  0001 C CNN
F 3 "" H 4700 2550 50  0001 C CNN
	1    4700 2550
	0    -1   -1   0   
$EndComp
Text GLabel 4500 4900 0    50   Input ~ 0
BCLK
Text GLabel 4500 4800 0    50   Input ~ 0
ADCLRC
Text GLabel 6400 5100 2    50   Input ~ 0
DACLRC
Text GLabel 4500 5100 0    50   Input ~ 0
ADCDAT
Text GLabel 4550 4100 0    50   Output ~ 0
DACDAT
$Comp
L parts:STM32G474CET6 U1
U 1 1 5E4703E9
P 5400 3150
F 0 "U1" H 5450 3250 50  0000 C CNN
F 1 "STM32G474CET6" H 5550 3150 50  0000 C CNN
F 2 "Housings_QFP:LQFP-48_7x7mm_Pitch0.5mm" H 5400 3150 50  0001 C CNN
F 3 "https://www.st.com/resource/en/datasheet/stm32g473cb.pdf" H 5400 3150 50  0001 C CNN
	1    5400 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 5100 6400 5100
Wire Wire Line
	6150 4700 6400 4700
Wire Wire Line
	6400 4800 6150 4800
$Comp
L power:GND #PWR0103
U 1 1 5E4AC91F
P 4550 4400
F 0 "#PWR0103" H 4550 4150 50  0001 C CNN
F 1 "GND" V 4555 4272 50  0000 R CNN
F 2 "" H 4550 4400 50  0001 C CNN
F 3 "" H 4550 4400 50  0001 C CNN
	1    4550 4400
	0    1    1    0   
$EndComp
Wire Wire Line
	4700 4400 4550 4400
Text GLabel 4550 4300 0    50   Input ~ 0
SW1
Text GLabel 7850 2000 0    50   Output ~ 0
SW1
Text GLabel 7850 2400 0    50   Output ~ 0
SW2
Text GLabel 7850 2750 0    50   Output ~ 0
SW3
Text GLabel 7850 3100 0    50   Output ~ 0
SW4
Text GLabel 4550 3050 0    50   Input ~ 0
SW2
Wire Wire Line
	4100 2850 4700 2850
Wire Wire Line
	3750 2750 4700 2750
Text GLabel 4550 3150 0    50   Input ~ 0
SW3
Text GLabel 4550 3250 0    50   Input ~ 0
SW4
$Comp
L Connector_Generic:Conn_01x04 J1
U 1 1 5E4DEDD9
P 8200 4900
F 0 "J1" H 8150 5250 50  0000 L CNN
F 1 "SWD" H 8100 5150 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 8200 4900 50  0001 C CNN
F 3 "~" H 8200 4900 50  0001 C CNN
	1    8200 4900
	1    0    0    1   
$EndComp
Text Notes 8300 4900 0    50   ~ 0
SWDIO
Wire Wire Line
	4550 3050 4700 3050
Wire Wire Line
	4550 3150 4700 3150
Wire Wire Line
	4550 3250 4700 3250
Wire Wire Line
	4550 4300 4700 4300
Text GLabel 6400 4600 2    50   Output ~ 0
SDA
Text GLabel 6400 4500 2    50   Output ~ 0
SCL
Wire Wire Line
	6150 4500 6400 4500
NoConn ~ 4700 3600
NoConn ~ 4700 3700
NoConn ~ 4700 3800
NoConn ~ 4700 4000
NoConn ~ 4700 4500
NoConn ~ 4700 4600
NoConn ~ 4700 5000
NoConn ~ 6150 3600
NoConn ~ 6150 3700
NoConn ~ 6150 4000
NoConn ~ 6150 4100
NoConn ~ 6150 4200
NoConn ~ 6150 4300
$Comp
L power:GND #PWR0105
U 1 1 5E57500F
P 5500 5600
F 0 "#PWR0105" H 5500 5350 50  0001 C CNN
F 1 "GND" H 5505 5427 50  0000 C CNN
F 2 "" H 5500 5600 50  0001 C CNN
F 3 "" H 5500 5600 50  0001 C CNN
	1    5500 5600
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x03 J6
U 1 1 5E57B910
P 6750 3900
F 0 "J6" H 6700 4250 50  0000 L CNN
F 1 "Serial" H 6650 4150 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 6750 3900 50  0001 C CNN
F 3 "~" H 6750 3900 50  0001 C CNN
	1    6750 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 3800 6550 3800
Wire Wire Line
	6150 3900 6550 3900
$Comp
L power:GND #PWR0106
U 1 1 5E58AEDF
P 6550 4000
F 0 "#PWR0106" H 6550 3750 50  0001 C CNN
F 1 "GND" V 6555 3872 50  0000 R CNN
F 2 "" H 6550 4000 50  0001 C CNN
F 3 "" H 6550 4000 50  0001 C CNN
	1    6550 4000
	0    1    1    0   
$EndComp
Text Notes 8300 5000 0    50   ~ 0
SWCLK
Text Notes 8300 4800 0    50   ~ 0
3v3
Text Notes 8300 4700 0    50   ~ 0
GND
Text Notes 6850 3800 0    50   ~ 0
TX
Text Notes 6850 3900 0    50   ~ 0
RX
Text Notes 6850 4000 0    50   ~ 0
GND
Wire Wire Line
	4550 4100 4700 4100
NoConn ~ 4700 4200
Wire Wire Line
	4500 4900 4700 4900
Text GLabel 4550 3900 0    50   Input ~ 0
BCLK
Wire Wire Line
	4550 3900 4700 3900
Text Notes 5670 5230 0    35   ~ 0
I2S3_WS
Wire Wire Line
	4500 5100 4700 5100
Text Notes 4920 5220 0    35   ~ 0
I2S2_SD
Wire Wire Line
	4500 4800 4700 4800
Text Notes 5170 4930 0    35   ~ 0
I2S2_CK
Text Notes 5170 4830 0    35   ~ 0
I2S2_WS
Text Notes 5120 4130 0    35   ~ 0
I2S3_SD
Text Notes 5120 3930 0    35   ~ 0
I2S3_CK
Text Notes 5460 3830 0    35   ~ 0
USART2_TX
Text Notes 5450 3920 0    35   ~ 0
USART2_RX
Text Notes 5460 4630 0    35   ~ 0
I2C2_SDA
Text Notes 5460 4520 0    35   ~ 0
I2C2_SCL
$Comp
L Device:LED D3
U 1 1 5E4009C6
P 3950 4700
F 0 "D3" H 3943 4916 50  0000 C CNN
F 1 "Debug" H 3943 4825 50  0000 C CNN
F 2 "LEDs:LED_0603_HandSoldering" H 3950 4700 50  0001 C CNN
F 3 "~" H 3950 4700 50  0001 C CNN
	1    3950 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 4700 4700 4700
$Comp
L Device:R R18
U 1 1 5E4050CB
P 3500 4700
F 0 "R18" V 3293 4700 50  0000 C CNN
F 1 "1.5k" V 3384 4700 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 3430 4700 50  0001 C CNN
F 3 "~" H 3500 4700 50  0001 C CNN
	1    3500 4700
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5E405DDC
P 3200 4700
F 0 "#PWR05" H 3200 4450 50  0001 C CNN
F 1 "GND" V 3205 4572 50  0000 R CNN
F 2 "" H 3200 4700 50  0001 C CNN
F 3 "" H 3200 4700 50  0001 C CNN
	1    3200 4700
	0    1    1    0   
$EndComp
Wire Wire Line
	3200 4700 3350 4700
Wire Wire Line
	3650 4700 3800 4700
Wire Wire Line
	7850 2000 9300 2000
Wire Wire Line
	7850 2400 9300 2400
Wire Wire Line
	7850 2750 9300 2750
Wire Wire Line
	7850 3100 9300 3100
Wire Wire Line
	5400 1850 5300 1850
Wire Wire Line
	5300 1850 5300 2200
Connection ~ 5400 1850
$Comp
L power:+3V3 #PWR0108
U 1 1 5E3FFADC
P 4500 3400
F 0 "#PWR0108" H 4500 3250 50  0001 C CNN
F 1 "+3V3" V 4515 3528 50  0000 L CNN
F 2 "" H 4500 3400 50  0001 C CNN
F 3 "" H 4500 3400 50  0001 C CNN
	1    4500 3400
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4500 3400 4700 3400
Wire Wire Line
	6150 5000 8000 5000
Wire Wire Line
	6150 4900 8000 4900
$Comp
L power:GND #PWR09
U 1 1 5E423761
P 7900 4700
F 0 "#PWR09" H 7900 4450 50  0001 C CNN
F 1 "GND" V 7905 4572 50  0000 R CNN
F 2 "" H 7900 4700 50  0001 C CNN
F 3 "" H 7900 4700 50  0001 C CNN
	1    7900 4700
	0    1    1    0   
$EndComp
Wire Wire Line
	7900 4800 8000 4800
Wire Wire Line
	7900 4700 8000 4700
Text Notes 5110 2770 0    35   ~ 0
OSC_IN
Text Notes 5100 2870 0    35   ~ 0
OSC_OUT
Wire Wire Line
	6150 4600 6400 4600
NoConn ~ 6150 4400
$EndSCHEMATC
