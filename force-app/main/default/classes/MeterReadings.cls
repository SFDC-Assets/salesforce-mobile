public with sharing class MeterReadings {

    public static void GenerateReadingsForAllStores() {
        List<Office__c> offices = [SELECT Id FROM Office__c];
        for (Office__c office : offices) {
            GenerateReadings(office.Id);
        }
    }

    public static void ResetReadingsForAllStores() {
        List<Meter_Reading__c> readings = [SELECT Id FROM Meter_Reading__c];
        delete readings;
    }

    public static void GenerateReadings(string recordId) {
        Integer numberOfReadingsToGenerate = 15;
        Integer currentDay = numberOfReadingsToGenerate;
        List<Meter_Reading__c> readings = new List<Meter_Reading__c>();
        Meter_Reading__c reading;
        do {
            readings.add(GenerateReading(recordId, currentDay));
            currentDay = currentDay - 1;
        } while (currentDay >= 0);
        insert readings;
    }

    public static Meter_Reading__c GenerateReading(string recordId, integer daysAgo) {
        Integer bonus =  daysAgo * 20;
        Integer baseUsage = 300 + bonus;
        Integer peakUsage = 400 + bonus;

        Integer energyUsage = randomInt(baseUsage, peakUsage);
        
        energyUsage = energyUsage - bonus;

        Meter_Reading__c reading = new Meter_Reading__c();
        reading.Office__c = recordId;
        reading.Days_Ago__c = daysAgo;
        reading.Energy_Used__c = energyUsage;
        System.System.debug('Here');
        return reading;
    }

    private static Integer randomInt(Integer lowerLimit, Integer upperLimit){
        Integer rand = Math.round(Math.random() * (upperLimit - lowerLimit)) + lowerLimit;
        return rand;
    }    
}