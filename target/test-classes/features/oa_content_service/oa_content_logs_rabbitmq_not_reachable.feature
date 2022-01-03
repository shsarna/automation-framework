@RegressionAll @Regression_Set1 @SP_72_US_11797 @DDIBA-12411
  #below tag is for hooks
@revertRabbitMqUrlOaContent

Feature: Verify oa-content-service logs for error when service could not connect to RabbitMQ during startup

  Scenario Outline: Verify oa-content-service logs for error when service could not connect to RabbitMQ during startup

    Given the 'oa-content-service' is available
    And the STD file '<Superxml_foldername>/<job_name>' is available at standalone adapter

    When the configmap 'oa-content-service-tsy-integration-configmap' has the property 'amqp.server.url' value set to '78c80150-330a-4c1a-86da-8016ce30152c.br38q28f0334iom5lv4g.private.databases.appdomain.cloudTEST' in 'application.properties'
    And the deployment 'oa-content-service-tsy-integration' is restarted
    And wait for 75 seconds
    And the command convert is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'

    Then verify the logs of 'oa-content-service' are similar with file '<test_folder>/then/logs_validation/log_oa_content_service_rabbitmq_not_reachable.txt'

    Examples:
      | test_folder                  | Superxml_foldername              | job_name                                   |
      | /testData/oa_content_service | standalone-adapter/Update_import | 586f397bd814790ac0a8c00145e5a56d_super.xml |


