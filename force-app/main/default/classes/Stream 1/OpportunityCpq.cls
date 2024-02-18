public with sharing class OpportunityCpq {
  public String name{get;set;}    

  public pagereference show() {
    name = 'This is my name' + name;
    return null;
  }
}