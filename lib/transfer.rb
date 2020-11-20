require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end
  def valid? 
    if !@sender || !@receiver
      return false
    else 
      @sender.valid? 
      @receiver.valid?
    end
  end
  def execute_transaction
    if valid? && sender.balance > amount && self.status == "pending"
      @sender.balance -= amount
      @receiver.balance += amount
      self.status = "complete"
    else 
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end
    def reverse_transfer
      if self.status == "complete"
        @sender.balance += amount
        @receiver.balance -= amount
        self.status = "reversed"
      end
    end
end