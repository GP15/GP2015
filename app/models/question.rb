class Question < ActiveRecord::Base

  enum brain: [:left_brain, :right_brain]

end
