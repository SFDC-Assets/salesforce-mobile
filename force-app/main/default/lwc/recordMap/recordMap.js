import { LightningElement, api, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

export default class RecordMap extends LightningElement {

    @api recordId;
    @api streetField;
    @api cityField
    @api stateField
    @api postalCodeField
    @api countryField

    get FIELDS() {
        return [
            this.streetField,
            this.cityField,
            this.stateField,
            this.postalCodeField
        ];
    }

    @wire(getRecord, {
        recordId: '$recordId',
        fields: '$FIELDS'
    }) record;

    get street() {
        return this.getField(this.streetField);
    }

    get city() {
        return this.getField(this.cityField);
    }

    get state() {
        return this.getField(this.stateField);
    }

    get postalCode() {
        return this.getField(this.postalCodeField);
    }   
    
    get mapMarkers() {
        return [
            {
                location: {
                    Street: this.address,
                    City: this.city,
                    State: this.state,
                    PostalCode: this.postalCode
                }
            }
        ]
    }

    getField(field) {
        var parts = field.split(".");
        if (parts.length == 2) {
            console.log('Stripped Object: ' + parts[1])
            field = parts[1];
        } else {
            console.log('Unable to strip Object from "' + value + '".')
            return "";
        }

        console.log('getField: ' + JSON.stringify(this.record));
        try {
            return this.record.data.fields[field].value;
        } catch(e) {
            console.log('ERROR: ' + e)
            return "";
        }        
    }
}