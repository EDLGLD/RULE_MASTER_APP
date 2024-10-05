class AdminMailer < ApplicationMailer
    default from: 'no-reply@example.com'
    
    def rule_request_notification(admin, rule_request)
        @admin = admin
        @rule_request = rule_request
        mail(to: @admin.email, subject: '修正リクエストが届きました')
      end
  end