require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  setup do
    @ticket = tickets(:ticket_1)
    @valid_arguments = {
      customer_name:   "Some valid name",
      customer_email:  "valid.email@gmail.com",
      department:      0,
      subject:         "Valid Subject",
      description:     "Mistakeless and clear description"
    }
  end

  test "does not create the ticket with invalid arguments" do
    new_ticket = Ticket.new @valid_arguments

    new_ticket.customer_name = 'X'
    new_ticket.save
    assert_not_nil new_ticket.errors[:customer_name]

    new_ticket.customer_email = 'invalid@email'
    new_ticket.save
    assert_not_nil new_ticket.errors[:customer_email]

    new_ticket.department = Ticket::DEPARTMENTS.size
    new_ticket.save
    assert_not_nil new_ticket.errors[:department]

    new_ticket.subject = "Y"
    new_ticket.save
    assert_not_nil new_ticket.errors[:subject]

    new_ticket.description = "Yo"
    new_ticket.save
    assert_not_nil new_ticket.errors[:description]
  end

  test 'create ticket with valid arguments' do
    new_ticket = Ticket.create @valid_arguments

    assert new_ticket.errors.empty?
  end
end
