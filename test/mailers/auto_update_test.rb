require 'test_helper'

class AutoUpdateTest < ActionMailer::TestCase
  test "partner_update" do
    mail = AutoUpdate.partner_update
    assert_equal "Partner update", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
