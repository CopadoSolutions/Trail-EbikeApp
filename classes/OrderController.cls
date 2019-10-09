/**
 * @description This controller is for the Order page.
 */
public with sharing class OrderController {

    /**
     * @description Retrieve the Order items related to an order
     * @param	orderId This Id of the order for which to retrieve the order item records.
     * @return	a list of order items.
     */
    @AuraEnabled(Cacheable=true)
    public static Order_Item__c[] getOrderItems(Id orderId) {
        return [SELECT Id, Qty_S__c, Qty_M__c, Qty_L__c, Price__c,
            Product__r.Name, Product__r.MSRP__c, Product__r.Picture_URL__c
            FROM Order_Item__c WHERE Order__c = :orderId];
    }
}