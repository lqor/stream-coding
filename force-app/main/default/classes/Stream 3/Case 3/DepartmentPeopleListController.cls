public with sharing class DepartmentPeopleListController {
    @AuraEnabled
    public static List<User> getAllUsersWithDepartments(){
        return [
            SELECT Id, Name, Email, Department
            FROM User
            WHERE Department != null
        ];
    }
}