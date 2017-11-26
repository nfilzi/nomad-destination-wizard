module ApplicationHelper
  def percentage_range_within(min, max)
    (0..100).step(10).to_a.select do |score|
      # score est juste en dessous de min
      (score <= min && (score + 10) > min) ||
      # score est entre min et max
      (score >= min && score <= max)
    end
  end
end
