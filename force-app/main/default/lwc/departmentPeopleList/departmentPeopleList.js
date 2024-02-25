import { LightningElement } from 'lwc';
import getAllUsersWithDepartments from '@salesforce/apex/DepartmentPeopleListController.getAllUsersWithDepartments';

export default class DepartmentPeopleList extends LightningElement {
    data = [];
    filteredData = [];
    departmentSelected = { label: 'All Departments', value: 'All Departments'};

    columns = [
        { label: 'User Name', fieldName: 'Name', type: 'text' },
        { label: 'Email', fieldName: 'Email', type: 'email' },
        { label: 'Department', fieldName: 'Department', type: 'text' }
    ];

    connectedCallback() {
        this.getAllUsersWithDepartments();
    }

    getAllUsersWithDepartments() {
        getAllUsersWithDepartments()
            .then(result => {
                this.data = result;
                this.filteredData = result;
            })
            .catch(error => {
                this.error = error;
            });
    }

    get options() {
        let departments = [];
    
        for(let dataEntry of this.data) {
    
            let newDepartmentEntry = { label: dataEntry.Department, value: dataEntry.Department };    
            let exists = departments.find(dept => dept.value === newDepartmentEntry.value);
        
            if(!exists) { 
                departments.push(newDepartmentEntry);
            }
        }

        departments.push({ label: 'All Departments', value: 'All Departments' });
        
        return departments;
    }

    handleChange(event) {
        this.departmentSelected = event.detail.value;

        if (this.departmentSelected === 'All Departments') {
            this.filteredData = this.data;
        } else {
            this.filteredData = this.data.filter(user => user.Department === this.departmentSelected);
        }

    }
}