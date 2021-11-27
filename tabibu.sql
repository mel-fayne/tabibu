-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 13, 2021 at 11:43 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tabibu`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `appointmentlist`
-- (See below for the actual view)
--
CREATE TABLE `appointmentlist` (
`apptid` int(11)
,`patientid` int(11)
,`doctorid` int(11)
,`date` varchar(255)
,`time` varchar(255)
,`location` varchar(255)
,`reason` longtext
,`status` enum('Unconfirmed','Confirmed','Done')
,`drname` varchar(255)
,`ptname` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `apptid` int(11) NOT NULL,
  `patientid` int(11) NOT NULL,
  `doctorid` int(11) NOT NULL,
  `date` varchar(255) NOT NULL,
  `time` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `reason` longtext NOT NULL,
  `status` enum('Unconfirmed','Confirmed','Done') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`apptid`, `patientid`, `doctorid`, `date`, `time`, `location`, `reason`, `status`) VALUES
(8, 1, 1, '2021-05-20', '11:00 AM', 'Kenyatta National Hospital', 'Tetanus Injection appointment ', 'Confirmed'),
(9, 1, 5, '20-05-2021', NULL, 'Aga Khan Hospital', 'Tooth Sugery Appointment ', 'Unconfirmed'),
(14, 1, 5, '15-06-2021', NULL, 'Aga Khan Hospital', 'Second Tooth Sugery Appointment ', 'Unconfirmed'),
(15, 6, 5, '27-05-2021', NULL, 'Aga Khan Hospital', 'Covid 19 Vaccination ', 'Unconfirmed'),
(16, 7, 9, '18-05-2021', '9:00 AM', 'Thika Level 5 Hospital', 'New Patient Request', 'Done'),
(17, 8, 10, '2021-05-25', '10:00 AM', 'Mpisha Hospital', 'New patient request', 'Done');

-- --------------------------------------------------------

--
-- Stand-in structure for view `doctorlist`
-- (See below for the actual view)
--
CREATE TABLE `doctorlist` (
`name` varchar(255)
,`specialty` text
,`hospital` text
,`practiceyrs` int(11)
,`pt_id` int(11)
,`dr_id` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `doctorid` int(11) NOT NULL,
  `hospital` text NOT NULL,
  `specialty` text NOT NULL,
  `practiceyrs` int(11) NOT NULL,
  `about` longtext NOT NULL,
  `liscence` varchar(255) NOT NULL,
  `days` text NOT NULL,
  `time` varchar(255) NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`doctorid`, `hospital`, `specialty`, `practiceyrs`, `about`, `liscence`, `days`, `time`, `userid`) VALUES
(1, 'Kenyatta National Hospital', 'General Doctor', 6, 'I\'m a General Doctor based in KNH and I\'ve been in medical practice for over 6 years. My core values in this practice revolve around fast diagnosis and excellent patient care.', 'D3478', 'Mondays & Wednesdays', '10:30am to 2pm', 3),
(5, 'Aga Khan Hospital', 'General Diagnostic', 11, 'I\'m a doctor who specializes in diagnostics. I have worked on the most mysterious of cases and believe that no case will remain unknown forever.', 'D3456', 'Monday to Friday', '12noon to 3pm', 37),
(7, 'Taita Taveta Hospital ', 'Pedetrician ', 25, 'I am a pedetrician in practice for over 20 years. I have a keen interest in child and nursing mothers health care. My core values as a doctor are tenderness and compassion.', 'D6617', 'Monday,Wednesday and Friday', '8am to 4pm', 44),
(9, 'Thika Level 5 Hospital', 'General Doctor', 12, 'I\'m a general doctor with a passion for quality patient care and effective diagnosis methods', 'D4562', 'Tuesdays and Thursdays', '9am to 12noon', 48),
(10, 'Mpisha Hospital', 'Pedetrician', 9, 'I\'m a genral doctor with a keen interest in childhood diseases and new born motheres\' helath care.', 'D2313', 'Monday to Friday', '8am to 10am', 50),
(13, 'Kenyatta National Hospital', 'General Doctor', 14, 'I\'m a General Doctor based in KNH and I\'ve been in medical practice for over 6 years. My core values in this practice revolve around fast diagnosis and excellent patient care.', 'D4534', 'Mondays, Wednesdays and Fridays', '8am to 12 noon', 52);

-- --------------------------------------------------------

--
-- Stand-in structure for view `doctorusers`
-- (See below for the actual view)
--
CREATE TABLE `doctorusers` (
`userid` int(11)
,`name` varchar(255)
,`email` varchar(255)
,`county` varchar(255)
,`doctorid` int(11)
,`hospital` text
,`specialty` text
,`practiceyrs` int(11)
,`about` longtext
,`liscence` varchar(255)
,`days` text
,`time` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `fulldiagnosis`
-- (See below for the actual view)
--
CREATE TABLE `fulldiagnosis` (
`recordid` int(11)
,`disease` text
,`description` longtext
,`date` varchar(255)
,`weight` varchar(255)
,`temp` varchar(255)
,`pulse` varchar(255)
,`pressure` varchar(255)
,`symptoms` longtext
,`medicine` text
,`prescription` varchar(255)
,`treatmentinfo` text
,`dr_id` int(11)
,`pt_id` int(11)
,`ptname` varchar(255)
,`drname` varchar(255)
,`hospital` text
,`status` enum('On Treatment','Closed')
);

-- --------------------------------------------------------

--
-- Table structure for table `medrecords`
--

CREATE TABLE `medrecords` (
  `recordid` int(11) NOT NULL,
  `disease` text NOT NULL,
  `description` longtext NOT NULL,
  `date` varchar(255) NOT NULL,
  `weight` varchar(255) NOT NULL,
  `temp` varchar(255) NOT NULL,
  `pulse` varchar(255) NOT NULL,
  `pressure` varchar(255) NOT NULL,
  `symptoms` longtext NOT NULL,
  `medicine` text NOT NULL,
  `prescription` varchar(255) NOT NULL,
  `treatmentinfo` text NOT NULL,
  `status` enum('On Treatment','Closed') NOT NULL,
  `dr_id` int(11) NOT NULL,
  `pt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medrecords`
--

INSERT INTO `medrecords` (`recordid`, `disease`, `description`, `date`, `weight`, `temp`, `pulse`, `pressure`, `symptoms`, `medicine`, `prescription`, `treatmentinfo`, `status`, `dr_id`, `pt_id`) VALUES
(1, 'Typhoid', 'Symptoms caused due to consumption of unboiled water with traces of sewage.', '2021-04-07', '56.45', '36.3', '45', '72', 'Diarrhoea, Stomachache, Loss of appetite, Weight Loss, Dehydration', 'Anti-Biotics', '2x3', 'Avoid fooods with milk during medication. Take drugs after a balanced diet', 'Closed', 1, 1),
(3, 'Blood Pressure', 'Patient suffers from high cholesterol levels in the atria section of the heart that constricts blood flow hence high blood pressure', '2021-04-19', '84.5', '36.4', '48', '85', 'Dizziness, Headache, Pain in chest area, Low pulse rate', 'Avastistatin', '1x2', 'Take after a balanced diet. Make sure there is a12 hour gap between the two medicine intakes per day', 'Closed', 1, 2),
(6, 'Cholera', 'Symptoms  caused by prolonged intake of dirty borehole water', '2021-05-03', '56', '37', '43', '78', 'Fever,Diarrhoea, Pain in Lower abdomen, Vomiting', 'Antibiotics and Betapian', '2x3, 1x3', 'The antibiotics prescription is 2x3 and the betapain prescription is 1x3. The betapain is a pain killer', 'Closed', 1, 2),
(7, 'Keneddy\'s Disease', 'The symptoms were caused due to consumption of oysters during a trip to Hong Kong. The symptoms were sustained due to lack of enough copper reduction mechanisms within the body enough', '2021-05-02', '67.5', '36', '34', '77', 'Fainting and Dizziness\r\nYellow rings around the eyes\r\nLack of appetite', 'Kelemin Drugs', '2x3', 'Avoid further consumption of oysters until advised otherwise by your doctors. Also try to avoid other foods with copper', 'Closed', 5, 1),
(8, 'Typhoid ', 'Symptoms started after consumption of unbelief drinking water ', '2021-05-13', '56', '38', '45', '77', 'Fever,Vomiting, Loss of appetite, Diarrhoea ', 'Antibiotics ', '2x3', 'Take drugs after a balanced diet', 'On Treatment', 9, 7),
(9, 'Typhoid', 'Symptoms caused by consumption of dirty water', '2021-05-13', '56', '37', '45', '72', 'Fever, Vomiting, Diarrhoea, loss of appetite', 'Antibiotics ', '2x3', 'Take after a balanced meal ', 'Closed', 10, 8);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `dob` varchar(255) NOT NULL,
  `preexisting_cond` varchar(255) NOT NULL,
  `blood_type` enum('A','B','AB','O') NOT NULL,
  `payment_mode` enum('NHIF','Cash') NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `dob`, `preexisting_cond`, `blood_type`, `payment_mode`, `userid`) VALUES
(1, '23/04/1998', 'Yes, Blood Pressure', 'B', 'NHIF', 2),
(2, '18/11/1976', 'No', 'AB', 'Cash', 5),
(3, '2021-05-05', 'Yes, Diabetes ', 'AB', 'NHIF', 40),
(4, '2021-05-05', 'None', 'O', 'NHIF', 41),
(6, '1998-05-06', 'Yes, Diabetes', 'B', 'NHIF', 45),
(7, '1994-05-03', 'Yes, Diabetes ', 'AB', 'Cash', 49),
(8, '1980-05-13', 'No', 'O', 'NHIF', 51);

-- --------------------------------------------------------

--
-- Stand-in structure for view `patientlist`
-- (See below for the actual view)
--
CREATE TABLE `patientlist` (
`patient_id` int(11)
,`name` varchar(255)
,`date` varchar(255)
,`disease` text
,`status` enum('On Treatment','Closed')
,`recordid` int(11)
,`dr_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `patientusers`
-- (See below for the actual view)
--
CREATE TABLE `patientusers` (
`userid` int(11)
,`name` varchar(255)
,`email` varchar(255)
,`county` varchar(255)
,`patient_id` int(11)
,`dob` varchar(255)
,`preexisting_cond` varchar(255)
,`blood_type` enum('A','B','AB','O')
,`payment_mode` enum('NHIF','Cash')
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `updatelist`
-- (See below for the actual view)
--
CREATE TABLE `updatelist` (
`updateid` int(11)
,`patientid` int(11)
,`doctorid` int(11)
,`date` varchar(255)
,`feel` text
,`partache` text
,`painrate` enum('Zero','One','Two',' Three','Four','Five')
,`newsymptom` text
,`sideeffect` text
,`medintake` enum('Yes','No')
,`additional` longtext
,`status` enum('Unseen','Seen')
,`ptname` varchar(255)
,`drname` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `updates`
--

CREATE TABLE `updates` (
  `updateid` int(11) NOT NULL,
  `patientid` int(11) NOT NULL,
  `doctorid` int(11) NOT NULL,
  `date` varchar(255) NOT NULL,
  `feel` text NOT NULL,
  `partache` text NOT NULL,
  `painrate` enum('Zero','One','Two',' Three','Four','Five') NOT NULL,
  `newsymptom` text NOT NULL,
  `sideeffect` text NOT NULL,
  `medintake` enum('Yes','No') NOT NULL,
  `additional` longtext NOT NULL,
  `status` enum('Unseen','Seen') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `updates`
--

INSERT INTO `updates` (`updateid`, `patientid`, `doctorid`, `date`, `feel`, `partache`, `painrate`, `newsymptom`, `sideeffect`, `medintake`, `additional`, `status`) VALUES
(1, 1, 1, '2021-04-13', 'I feel a bit of pain', 'Head', 'Two', 'Yes, I\'ve developed a rush on my neck', 'None', 'No', 'The treatment seems to be working since I have less pain on my lower abdomen', 'Seen'),
(3, 1, 5, '2021-04-07', 'I feel much better now', 'None', 'Zero', 'No new symptom expect a rush I\'ve developed on my neck. It\'s spreading fast and really itches at night time.', 'None, aside from the rush maybe', 'Yes', 'I have less pain in my joints and less fever outbreaks', 'Seen'),
(4, 1, 5, '2021-05-05', 'I feel less dizzy and faint', 'My head still aches from the dizziness ', 'Two', 'None', 'No side effects', 'Yes', 'The copper rings in my eyes seem to disappear and I have more stregth and less fainting spells', 'Unseen'),
(5, 7, 9, '2021-05-13', 'I feel better after taking the drugs ', 'Yes, my stomach ', 'One', 'None', 'None', 'Yes', 'I have les fever outbreaks and I feel more energetic ', 'Seen'),
(6, 8, 10, '2021-05-13', 'I feel much better', 'None', 'Zero', 'None', 'None', 'Yes', 'I have less vomiting outbreaks and I feel less pain in my lower abdomen', 'Seen');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `county` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `role` enum('patient','doctor') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `name`, `email`, `county`, `pass`, `role`) VALUES
(2, 'John Doe', 'patient@gmail.com', 'Nairobi ', '1224', 'patient'),
(3, 'Jules Rue', 'doctor@gmail.com', 'Kajiado', 'n', 'doctor'),
(5, 'Keya Mia', 'patient2@gmail.com', 'Lamu', 'keya', 'patient'),
(37, 'Brenda Mwilu', 'brenda@gmail.com', 'Eldoret', 'ds67', 'doctor'),
(40, 'Henry Hart ', 'hart45@gmail.com', 'Lamu', 'fg56', 'patient'),
(41, 'Tamara Imali', 'tia67@gmail.com', 'Nairobi', 'gh89', 'patient'),
(44, 'May Page', 'page@gmail.com', 'Taita Taveta', 'bn78', 'doctor'),
(45, 'Gigi Juma', 'juma@gmail.com', 'Mombasa', '56', 'patient'),
(48, 'Michael Kenda', 'kenda@gmail.com', 'Thika ', 'kenda01', 'doctor'),
(49, 'Faith Mueni', 'mueni@gmail.com', 'Thika', '5678', 'patient'),
(50, 'Juma Oweo', 'oweo@gmail.com', 'Busia', '1234', 'doctor'),
(51, 'Lena Kalua', 'lena@gmail.com', 'Nairobi ', '5678', 'patient'),
(52, 'Kennedy Lumumba', 'ken@gmail.com', 'Nairobi', '8341', 'doctor');

-- --------------------------------------------------------

--
-- Structure for view `appointmentlist`
--
DROP TABLE IF EXISTS `appointmentlist`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `appointmentlist`  AS SELECT `appointments`.`apptid` AS `apptid`, `appointments`.`patientid` AS `patientid`, `appointments`.`doctorid` AS `doctorid`, `appointments`.`date` AS `date`, `appointments`.`time` AS `time`, `appointments`.`location` AS `location`, `appointments`.`reason` AS `reason`, `appointments`.`status` AS `status`, `doctorusers`.`name` AS `drname`, `patientusers`.`name` AS `ptname` FROM ((`appointments` join `doctorusers` on(`doctorusers`.`doctorid` = `appointments`.`doctorid`)) join `patientusers` on(`patientusers`.`patient_id` = `appointments`.`patientid`)) ;

-- --------------------------------------------------------

--
-- Structure for view `doctorlist`
--
DROP TABLE IF EXISTS `doctorlist`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `doctorlist`  AS SELECT `doctorusers`.`name` AS `name`, `doctorusers`.`specialty` AS `specialty`, `doctorusers`.`hospital` AS `hospital`, `doctorusers`.`practiceyrs` AS `practiceyrs`, `medrecords`.`pt_id` AS `pt_id`, `medrecords`.`dr_id` AS `dr_id` FROM (`doctorusers` join `medrecords` on(`doctorusers`.`doctorid` = `medrecords`.`dr_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `doctorusers`
--
DROP TABLE IF EXISTS `doctorusers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `doctorusers`  AS SELECT `users`.`userid` AS `userid`, `users`.`name` AS `name`, `users`.`email` AS `email`, `users`.`county` AS `county`, `doctors`.`doctorid` AS `doctorid`, `doctors`.`hospital` AS `hospital`, `doctors`.`specialty` AS `specialty`, `doctors`.`practiceyrs` AS `practiceyrs`, `doctors`.`about` AS `about`, `doctors`.`liscence` AS `liscence`, `doctors`.`days` AS `days`, `doctors`.`time` AS `time` FROM (`users` join `doctors` on(`users`.`userid` = `doctors`.`userid`)) ;

-- --------------------------------------------------------

--
-- Structure for view `fulldiagnosis`
--
DROP TABLE IF EXISTS `fulldiagnosis`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `fulldiagnosis`  AS SELECT `medrecords`.`recordid` AS `recordid`, `medrecords`.`disease` AS `disease`, `medrecords`.`description` AS `description`, `medrecords`.`date` AS `date`, `medrecords`.`weight` AS `weight`, `medrecords`.`temp` AS `temp`, `medrecords`.`pulse` AS `pulse`, `medrecords`.`pressure` AS `pressure`, `medrecords`.`symptoms` AS `symptoms`, `medrecords`.`medicine` AS `medicine`, `medrecords`.`prescription` AS `prescription`, `medrecords`.`treatmentinfo` AS `treatmentinfo`, `medrecords`.`dr_id` AS `dr_id`, `medrecords`.`pt_id` AS `pt_id`, `patientusers`.`name` AS `ptname`, `doctorusers`.`name` AS `drname`, `doctorusers`.`hospital` AS `hospital`, `medrecords`.`status` AS `status` FROM ((`medrecords` join `patientusers` on(`patientusers`.`patient_id` = `medrecords`.`pt_id`)) join `doctorusers` on(`doctorusers`.`doctorid` = `medrecords`.`dr_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `patientlist`
--
DROP TABLE IF EXISTS `patientlist`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patientlist`  AS SELECT `patientusers`.`patient_id` AS `patient_id`, `patientusers`.`name` AS `name`, `medrecords`.`date` AS `date`, `medrecords`.`disease` AS `disease`, `medrecords`.`status` AS `status`, `medrecords`.`recordid` AS `recordid`, `medrecords`.`dr_id` AS `dr_id` FROM (`patientusers` join `medrecords` on(`patientusers`.`patient_id` = `medrecords`.`pt_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `patientusers`
--
DROP TABLE IF EXISTS `patientusers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patientusers`  AS SELECT `users`.`userid` AS `userid`, `users`.`name` AS `name`, `users`.`email` AS `email`, `users`.`county` AS `county`, `patient`.`patient_id` AS `patient_id`, `patient`.`dob` AS `dob`, `patient`.`preexisting_cond` AS `preexisting_cond`, `patient`.`blood_type` AS `blood_type`, `patient`.`payment_mode` AS `payment_mode` FROM (`users` join `patient` on(`users`.`userid` = `patient`.`userid`)) ;

-- --------------------------------------------------------

--
-- Structure for view `updatelist`
--
DROP TABLE IF EXISTS `updatelist`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `updatelist`  AS SELECT `updates`.`updateid` AS `updateid`, `updates`.`patientid` AS `patientid`, `updates`.`doctorid` AS `doctorid`, `updates`.`date` AS `date`, `updates`.`feel` AS `feel`, `updates`.`partache` AS `partache`, `updates`.`painrate` AS `painrate`, `updates`.`newsymptom` AS `newsymptom`, `updates`.`sideeffect` AS `sideeffect`, `updates`.`medintake` AS `medintake`, `updates`.`additional` AS `additional`, `updates`.`status` AS `status`, `patientusers`.`name` AS `ptname`, `doctorusers`.`name` AS `drname` FROM ((`updates` join `patientusers`) join `doctorusers` on(`updates`.`patientid` = `patientusers`.`patient_id` and `updates`.`doctorid` = `doctorusers`.`doctorid`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`apptid`),
  ADD KEY `patientid` (`patientid`),
  ADD KEY `doctorid` (`doctorid`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`doctorid`),
  ADD UNIQUE KEY `userid_2` (`userid`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `medrecords`
--
ALTER TABLE `medrecords`
  ADD PRIMARY KEY (`recordid`),
  ADD KEY `pt_id` (`pt_id`),
  ADD KEY `dr_id` (`dr_id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `updates`
--
ALTER TABLE `updates`
  ADD PRIMARY KEY (`updateid`),
  ADD KEY `patientid` (`patientid`),
  ADD KEY `doctorid` (`doctorid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `apptid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `doctorid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `medrecords`
--
ALTER TABLE `medrecords`
  MODIFY `recordid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `updates`
--
ALTER TABLE `updates`
  MODIFY `updateid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctorid`) REFERENCES `doctors` (`doctorid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`patientid`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `medrecords`
--
ALTER TABLE `medrecords`
  ADD CONSTRAINT `medrecords_ibfk_1` FOREIGN KEY (`dr_id`) REFERENCES `doctors` (`doctorid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `medrecords_ibfk_2` FOREIGN KEY (`pt_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `updates`
--
ALTER TABLE `updates`
  ADD CONSTRAINT `updates_ibfk_1` FOREIGN KEY (`patientid`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `updates_ibfk_2` FOREIGN KEY (`doctorid`) REFERENCES `doctors` (`doctorid`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
