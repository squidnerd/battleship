class Board
    attr_reader :size

    def self.print_grid(grid_arr)
        grid_arr.each do |row|
            puts row.join(" ")
        end
    end

    def initialize(n)
        @grid = Array.new(n) {Array.new(n, :N)}
        @size = n * n 
    end

    def [](indices)
        @grid[indices[0]][indices[1]]
    end

    def []=(position, value)
        row, col = position
        @grid[row][col] = value
    end

    def num_ships
        @grid.flatten.count(:S)
    end

    def attack(position)
        if self[position] == :S 
            self[position] = :H
            puts "You sunk my battleship!"
            return true
        else
            self[position] = :X
            return false
        end
    end

    def place_random_ships
        total = @size / 4.0
        used_positions = []
        while used_positions.length < total do 
            position = [rand(0...@grid.length), rand(0...@grid.length)]
            if !used_positions.include?(position)
                self[position] = :S
                used_positions << position
            end
        end
    end

    def hidden_ships_grid
        new_grid = []
        @grid.map do |row|
            row.map do |item|
                if item == :S 
                    :N
                else
                    item
                end
            end
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print 
        Board.print_grid(self.hidden_ships_grid)
    end
  
end
