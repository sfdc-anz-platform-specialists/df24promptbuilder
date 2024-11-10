public with sharing class SummarizeCustomerFeedbackPromptExtension {

    @InvocableMethod(CapabilityType='FlexTemplate://Summarize_Customer_Reviews') // Matches API Name of template*/
    public static List<Response> getPrompt(List<Request> requests) {
      Request input = requests[0];
      List<Response> responses = new List<Response>();
      List<Reviews__c> lstReviews = [Select Feedback__c From Reviews__c Where Product__c = :input.Bike.Id ORDER BY CreatedDate DESC Limit 100 ];
  
      Response output = new Response();
      output.Prompt = 'Customer Reviews: \n';
      for(Reviews__c r: lstReviews) {
        // Build the prompt
        output.Prompt += r.Feedback__c + '\n';
      }
      responses.add(output);
      return responses;
    }
    
    // Type and Name of all variables must match as defined when creating the template
    public class Request {
      @InvocableVariable
      public Product__c Bike;
    }
  
    public class Response {
      @InvocableVariable(required=true)
      public String Prompt;
    }
}