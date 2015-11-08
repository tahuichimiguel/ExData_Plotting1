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

tot_energ_sub_meter1<-c(day1_energ_sub_meter1,day2_energ_sub_meter1)
tot_energ_sub_meter2<-c(day1_energ_sub_meter2,day2_energ_sub_meter2)
tot_energ_sub_meter3<-c(day1_energ_sub_meter3,day2_energ_sub_meter3)

day1_voltage<-as.numeric(levels(day1_data$Voltage))[day1_data$Voltage]
day2_voltage<-as.numeric(levels(day2_data$Voltage))[day2_data$Voltage]
tot_volts<-c(day1_voltage,day2_voltage)

day1_react_pow<-as.numeric(levels(day1_data$Global_reactive_power))[day1_data$Global_reactive_power]
day2_react_pow<-as.numeric(levels(day2_data$Global_reactive_power))[day2_data$Global_reactive_power]
tot_react_pow<-c(day1_react_pow,day2_react_pow)

#Plot4
par(mfrow=c(2,2), mar=c(4,4,2,1))

plot(tot_date_time,tot_act_pow,type='l',xlab='',ylab='Global Active Power (kilowatts)')

plot(tot_date_time,tot_volts,type='l',xlab='datetime',ylab='Voltage')

plot(tot_date_time,tot_energ_sub_meter1,type='l',col='black',xlab='',ylab='Energy sub Metering')
lines(tot_date_time,tot_energ_sub_meter2,type='l',col='red')
lines(tot_date_time,tot_energ_sub_meter3,type='l',col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'),lty=1,cex=.6)

plot(tot_date_time,tot_react_pow,type='l',xlab='datetime',ylab='Global_Reactive_Power')

dev.copy(png,file='plot4.png',width=480,height=480)
dev.off()