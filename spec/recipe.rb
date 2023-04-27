# Recipe class for storing and describing recipes

class Recipe
  @@recipes = {}

  def self.clear
    @@recipes = {}
  end

  def self.describe(&block)
    instance_eval(&block)
  end

  def self.recipe(name, &block)
    recipe = Recipe.new(name)
    recipe.instance_eval(&block)
    @@recipes[name] = recipe
  end

  def self.for(name)
    @@recipes[name]
  end

  attr_reader :name, :ingredients, :method_steps

  def initialize(name)
    @name = name
    @ingredients = []
    @method_steps = []
  end

  # adds an ingredient to the recipe's ingredient array
  def ingredient(ingredient)
    @ingredients << ingredient
  end

  # evaluates a block of method steps in the context of the Recipe instance  
  def method(&block)
    instance_eval(&block)
  end

  # adds a method step to the recipe's method step array
  def step(step)
    @method_steps << step
  end
end