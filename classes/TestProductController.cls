/**
 * @description Test Class for Product Controller
 */
@isTest
public class TestProductController {

    @testSetup
    static void createProducts() {
        List<Product__c> products = new List<Product__c>();
        products.add(new Product__c(Name='Sample Bike 1', MSRP__c=1000, Category__c='Mountain', Level__c='Beginner', Material__c='Carbon'));
        products.add(new Product__c(Name='Sample Bike 2', MSRP__c=1200, Category__c='Mountain', Level__c='Beginner', Material__c='Carbon'));
        insert products;
    }

    /**
     * @description Looping query
     * @return      void
     */
    @isTest
    static void loopQuery() {
        for (Integer i = 0; i < 10; i++) {
            List<Account> accounts = [SELECT Id FROM Account];
        }
    }

    /**
     * @description Validate that the getProducts method works with the right filtering criteria.
     * @return      void
     */
/*
    @isTest
    static void testGetProducts() {
        String filters = '{"searchKey":"Sample", "maxPrice":2000, "categories": ["Mountain"], "levels": ["Beginner"], "materials":["Carbon"]}, 1';
        PagedResult result = ProductController.getProducts(filters, 1);
        System.assertEquals(result.records.size(), 2);
    }
*/

    /**
     * @description Validate that the getSimilarProducts method returns records when passed an ID and no product family.
     * @return      void
     */
/*
    @isTest
    static void testGetSimilarProducts() {
        String filters = '{"searchKey":"Sample", "maxPrice":2000, "categories": ["Mountain"], "levels": ["Beginner"], "materials":["Carbon"]}, 1';
        PagedResult result = ProductController.getProducts(filters, 1);
        Product__c productToCompare = (Product__c)result.records[0];
        Product__c[] products = ProductController.getSimilarProducts(productToCompare.Id, null);
        System.assertEquals(products.size(), 1);
    }
*/
}