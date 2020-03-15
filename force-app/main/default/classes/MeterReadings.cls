public with sharing class MeterReadings {

    public static void GenerateReadingsForAllStores() {
        List<Store__c> stores = [SELECT Id FROM Store__c];
        for (Store__c store : stores) {
            GenerateReadings(store.Id);
        }
    }

    public static void GenerateReadings(string recordId) {
        Integer numberOfReadingsToGenerate = 30;
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
        Integer baseUsage = 1000;
        Integer peakUsage = 2000;
        Integer maxBonus = 500;

        Integer energyUsage = randomInt(baseUsage, peakUsage);
        Integer bonus =  maxBonus - Math.round(energyUsage * (daysAgo / 100));
        energyUsage = energyUsage - bonus;

        Meter_Reading__c reading = new Meter_Reading__c();
        reading.Store__c = recordId;
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
