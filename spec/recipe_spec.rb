require_relative 'recipe'

describe Recipe do
  before do
    Recipe.clear

    Recipe.describe do
      recipe 'Pancake' do
        ingredient 'Store-bought pancake mix'
        ingredient 'Water'

        method do
          step 'Mix the ingredients'
          step 'Cook them in a pan'
        end
      end

      recipe 'Miso Soup' do
        ingredient 'Tofu'
        ingredient 'White miso paste'

        method do
          step 'Mix miso paste into boiling water'
          step 'Add tofu and serve'
        end
      end
    end
  end

  describe '.clear' do
    it 'removes all recipes' do
      Recipe.clear
      expect(Recipe.for('Pancake')).to be_nil
      expect(Recipe.for('Miso Soup')).to be_nil
    end
  end

  describe '#initialize' do
    it 'sets the name of the recipe' do
      recipe = Recipe.new('Test Recipe')
      expect(recipe.name).to eq 'Test Recipe'
    end

    it 'initializes empty arrays for ingredients and method steps' do
      recipe = Recipe.new('Test Recipe')
      expect(recipe.ingredients).to eq []
      expect(recipe.method_steps).to eq []
    end
  end

  describe '#ingredient' do
    it 'adds an ingredient to the recipe' do
      recipe = Recipe.new('Test Recipe')
      recipe.ingredient('New Ingredient')
      expect(recipe.ingredients).to eq ['New Ingredient']
    end
  end

  describe '.for' do
    it 'records the ingredients and method of each recipe' do
      pancake_recipe = Recipe.for('Pancake')
  
      expect(pancake_recipe.name).to eq 'Pancake'
      expect(pancake_recipe.ingredients).to eq ['Store-bought pancake mix', 'Water']
      expect(pancake_recipe.method_steps).to eq ['Mix the ingredients', 'Cook them in a pan']
  
      soup_recipe = Recipe.for('Miso Soup')
  
      expect(soup_recipe.name).to eq 'Miso Soup'
      expect(soup_recipe.ingredients).to eq ['Tofu', 'White miso paste']
      expect(soup_recipe.method_steps).to eq ['Mix miso paste into boiling water', 'Add tofu and serve']
    end

    it 'returns nil if the recipe is not found' do
      recipe = Recipe.for('Non-existent Recipe')
      expect(recipe).to be_nil
    end
  end
end