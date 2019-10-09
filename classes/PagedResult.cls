/**
 * @description This is a wrapper class for the Paged Result.
 */
public with sharing class PagedResult {
    /**
     * @description The number of records shown per page.
     * @return	The number of records per page.
     */
    @AuraEnabled
    public Integer pageSize { get;set; }
    
    /**
     * @description This returns the current page number.
     * @return	The page number for the records currently returned.
     */
    @AuraEnabled
    public Integer pageNumber { get;set; }
    
    /**
     * @description The total item count of the records in the search.
     * @return	The number of records within the search.
     */
    @AuraEnabled
    public Integer totalItemCount { get;set; }
    
    /**
     * @description Used to capture the records for a paged result.
     * @return	a list of records.
     */
    @AuraEnabled
    public Object[] records { get;set; }
}