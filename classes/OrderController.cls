/**
 * @description This controller is for the Order page.
 */
public with sharing class OrderController {

    /**
     * @description Retrieve the Order items related to an order
     * @param   orderId This Id of the order for which to retrieve the order item records.
     * @return  a list of order items.
     */
    @AuraEnabled(Cacheable=true)
    public static Order_Item__c[] getOrderItems(Id orderId) {
        if (!Schema.sObjectType.Order_Item__c.fields.Qty_S__c.isAccessible()) { return null; }
        if (!Schema.sObjectType.Order_Item__c.fields.Qty_M__c.isAccessible()) { return null; }
        if (!Schema.sObjectType.Order_Item__c.fields.Qty_L__c.isAccessible()) { return null; }
        if (!Schema.sObjectType.Order_Item__c.fields.Price__c.isAccessible()) { return null; }
        if (!Schema.sObjectType.Order_Item__c.fields.Product__c.isAccessible()) { return null; }
        if (!Schema.sObjectType.Product__c.fields.Name.isAccessible()) { return null; }
        if (!Schema.sObjectType.Product__c.fields.MSRP__c.isAccessible()) { return null; }
        if (!Schema.sObjectType.Product__c.fields.Picture_URL__c.isAccessible()) { return null; }
        return [select Id, Qty_S__c, Qty_M__c, Qty_L__c, Price__c, Product__r.Name, Product__r.MSRP__c, Product__r.Picture_URL__c from Order_Item__c where Order__c = :orderId];
    }
}