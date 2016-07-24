module QuestionsHelper

  def yes_btn_data(question)
    if question.brain == :left_brain
      return 'left'
    else
      return 'right'
    end
  end

  def no_btn_data(question)
    if question.brain == :left_brain
      return 'right'
    else
      return 'left'
    end
  end

end
