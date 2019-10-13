/**
 * @description This is the controller for the product summary page.
 */
public with sharing class ProductController {

    static Integer page_size = 9;

    /**
     * @description Twrapper class for filters
     */
    public class Filters {
        /**
         * @description Getter/Setter
         * @return  String Array.
         */
        public String searchKey { get;set; }

        /**
         * @description Getter/Setter
         * @return  String Array.
         */
        public Decimal maxPrice { get;set; }

        /**
         * @description Getter/Setter
         * @return  String Array.
         */
        public String[] categories { get;set; }

        /**
         * @description Getter/Setter
         * @return  String Array.
         */
        public String[] materials { get;set; }

        /**
         * @description Getter/Setter
         * @return  String Array.
         */
        public String[] levels { get;set; }
    }

    /**
     * @description get the products
     * @param   filters     Get the products for a given filter criteria.
     * @param   pageNumber  Filter the range based on the page number derived from the pagination.
     * @return  the PageResult object.
     */
    @AuraEnabled(Cacheable=true)
    public static PagedResult getProducts(String filters, Integer pageNumber) {
        String key = '';
        String whereClause = '';
        Decimal maxPrice;
        String[] categories = new String[]{};
        String[] materials = new String[]{};
        String[] levels = new String[]{};
        String[] criteria = new String[]{};
        if (!String.isEmpty(filters)) {
            Filters productFilters = (Filters) JSON.deserializeStrict(filters, ProductController.Filters.class);
            maxPrice = productFilters.maxPrice;
            materials = productFilters.materials;
            levels = productFilters.levels;
            if (!String.isEmpty(productFilters.searchKey)) {
                key = '%' + productFilters.searchKey + '%';
                criteria.add('Name LIKE :key');
            }
            if (productFilters.maxPrice >= 0) {
                maxPrice = productFilters.maxPrice;
                criteria.add('MSRP__c <= :maxPrice');
            }
            if (productFilters.categories != null) {
                categories = productFilters.categories;
                criteria.add('Category__c IN :categories');
            }                      
            if (productFilters.levels != null) {
                levels = productFilters.levels;
                criteria.add('Level__c IN :levels');
            }                      
            if (productFilters.materials != null) {
                materials = productFilters.materials;
                criteria.add('Material__c IN :materials');
            }
            if (criteria.size() > 0) {
                whereClause = 'WHERE ' + String.join( criteria, ' AND ' );
            }                      
        }
        Integer pageSize = ProductController.page_size;
        Integer offset = (pageNumber - 1) * pageSize;
        PagedResult result =  new PagedResult();
        result.pageSize = pageSize;
        result.pageNumber = pageNumber;
        result.totalItemCount = Database.countQuery('SELECT count() FROM Product__c ' + whereClause);
        result.records = Database.query('SELECT Id, Name, MSRP__c, Description__c, Category__c, Level__c, Picture_URL__c, Material__c FROM Product__c ' + whereClause + ' ORDER BY Name LIMIT :pageSize OFFSET :offset');
        return result;
    }

    /**
     * @description For a selected product, also retrieve similar products
     * @param   productId   The ID of the product currently on display.
     * @param   familyId    The ID of the product family.
     * @return  a list of products.
     */
    @AuraEnabled(Cacheable=true)
    public static Product__c[] getSimilarProducts(Id productId, Id familyId) {
        if (!Schema.sObjectType.Product__c.fields.Name.isAccessible()) { return null; }
        if (!Schema.sObjectType.Product__c.fields.MSRP__c.isAccessible()) { return null; }
        if (!Schema.sObjectType.Product__c.fields.Description__c.isAccessible()) { return null; }
        if (!Schema.sObjectType.Product__c.fields.Category__c.isAccessible()) { return null; }
        if (!Schema.sObjectType.Product__c.fields.Level__c.isAccessible()) { return null; }
        if (!Schema.sObjectType.Product__c.fields.Picture_URL__c.isAccessible()) { return null; }
        if (!Schema.sObjectType.Product__c.fields.Material__c.isAccessible()) { return null; }
        return [SELECT Id, Name, MSRP__c, Description__c, Category__c, Level__c, Picture_URL__c, Material__c FROM Product__c WHERE Product_Family__c=:familyId AND Id!=:productId];
    }
}