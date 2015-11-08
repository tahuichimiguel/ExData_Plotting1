my_data<-read.delim('household_power_consumption.txt',header=TRUE, sep=';')


day1_data<- my_data[which(as.Date(my_data$Date,"%d/%m/%Y")==as.Date('01/02/2007','%d/%m/%Y')),]
day2_data<-my_data[which(as.Date(my_data$Date,"%d/%m/%Y")==as.Date('02/02/2007',"%d/%m/%Y")),]

##
day1_date_time_chars<- c(paste(as.character(day1_data$Date),as.character(day1_data$Time),sep=' '))
day1_date_time<- strptime(day1_date_time_chars,"%d/%m/%Y %H:%M:%S")
day1_date_time<- as.POSIXlt(day1_date_time)

day2_date_time_chars<- c(paste(as.character(day2_data$Date),as.character(day2_data$Time),sep=' '))
day2_date_time<- strptime(day2_date_time_chars,"%d/%m/%Y %H:%M:%S")
day2_date_time<- as.POSIXlt(day2_date_time)

tot_date_time<-c(day1_date_time,day2_date_time)

day1_glob_act_pow <- as.numeric(levels(day1_data$Global_active_power))[day1_data$Global_active_power]
day1_energ_sub_meter1<-as.numeric(levels(day1_data$Sub_metering_1))[day1_data$Sub_metering_1]
day1_energ_sub_meter2<-as.numeric(levels(day1_data$Sub_metering_2))[day1_data$Sub_metering_2]
day1_energ_sub_meter3<-day1_data$Sub_metering_3

day2_glob_act_pow <- as.numeric(levels(day2_data$Global_active_power))[day2_data$Global_active_power]
day2_energ_sub_meter1<-as.numeric(levels(day2_data$Sub_metering_1))[day2_data$Sub_metering_1]
day2_energ_sub_meter2<-as.numeric(levels(day2_data$Sub_metering_2))[day2_data$Sub_metering_2]
day2_energ_sub_meter3<-day2_data$Sub_metering_3

tot_act_pow<-c(day1_glob_act_pow,day2_glob_act_pow)

#Plot1
hist(tot_act_pow, col='red',xlab = 'Global Active Power (kilowatts)',
     xlim=c(0,6),breaks =13,main ='Global Active Power')

dev.copy(png,file='plot1.png',width=480,height=480)
dev.off()