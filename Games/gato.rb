class Player
  def initialize(id)
    @id = id
    @wins = 0
    print "Nombre del jugador #{id} "
    @nombre = gets.chomp
  end

  def getName
    @nombre
  end

  def to_s
    %(
      Nombre: #{@nombre}
      Victorias: #{@wins}
    )
  end

  def addWin
    @wins += 1
  end
end

class Tablero
  def initialize()
    @tablero =   [1, 2, 3,
                  4, 5, 6,
                  7, 8, 9]
    @player1 = Player.new(1)
    @player2 = Player.new(2)
  end

  def checkWinP1
    if @tablero[0] == 'X' && @tablero[1] == 'X' && @tablero[2] == 'X'
      puts "#{@player1.getName} Ganaste :D"
      @player1.addWin
      return true

    elsif @tablero[3] == 'X' && @tablero[4] == 'X' && @tablero[5] == 'X'
      puts "#{@player1.getName} Ganaste :D"
      @player1.addWin
      return true

    elsif @tablero[6] == 'X' && @tablero[7] == 'X' && @tablero[8] == 'X'
      puts "#{@player1.getName} Ganaste :D"
      @player1.addWin
      return true

    elsif @tablero[0] == 'X' && @tablero[3] == 'X' && @tablero[6] == 'X'
      puts "#{@player1.getName} Ganaste :D"
      @player1.addWin
      return true

    elsif @tablero[1] == 'X' && @tablero[4] == 'X' && @tablero[7] == 'X'
      puts "#{@player1.getName} Ganaste :D"
      @player1.addWin
      return true

    elsif @tablero[2] == 'X' && @tablero[5] == 'X' && @tablero[8] == 'X'
      puts "#{@player1.getName} Ganaste :D"
      @player1.addWin
      return true

    elsif @tablero[0] == 'X' && @tablero[4] == 'X' && @tablero[8] == 'X'
      puts "#{@player1.getName} Ganaste :D"
      @player1.addWin
      return true

    elsif @tablero[2] == 'X' && @tablero[4] == 'X' && @tablero[6] == 'X'
      puts "#{@player1.getName} Ganaste :D"
      @player1.addWin
      return true
    else
      return false
    end
  end

    def checkWinP2
      if @tablero[0] == 'O' && @tablero[1] == 'O' && @tablero[2] == 'O'
        puts "#{@player2.getName} Has Ganado !"
        @player2.addWin
        return true

      elsif @tablero[3] == 'O' && @tablero[4] == 'O' && @tablero[5] == 'O'
        puts "#{@player2.getName} Has Ganado !"
        @player2.addWin
        return true

      elsif @tablero[6] == 'O' && @tablero[7] == 'O' && @tablero[8] == 'O'
        puts "#{@player2.getName} Has Ganado !"
        @player2.addWin
        return true

      elsif @tablero[0] == 'O' && @tablero[3] == 'O' && @tablero[6] == 'O'
        puts "#{@player2.getName} Has Ganado !"
        @player2.addWin
        return true

      elsif @tablero[1] == 'O' && @tablero[4] == 'O' && @tablero[7] == 'O'
        puts "#{@player2.getName} Has Ganado !"
        @player2.addWin
        return true

      elsif @tablero[2] == 'O' && @tablero[5] == 'O' && @tablero[8] == 'O'
        puts "#{@player2.getName} Has Ganado !"
        @player2.addWin
        return true

      elsif @tablero[0] == 'O' && @tablero[4] == 'O' && @tablero[8] == 'O'
        puts "#{@player2.getName} Has Ganado !"
        @player2.addWin
        return true

      elsif @tablero[2] == 'O' && @tablero[4] == 'O' && @tablero[6] == 'O'
        puts "#{@player2.getName} Has Ganado !"
        @player2.addWin
        return true
      else
        return false
      end
    end

    def to_s
      %Q(
        #{@tablero[0]}|#{@tablero[1]}|#{@tablero[2]}
        - - -
        #{@tablero[3]}|#{@tablero[4]}|#{@tablero[5]}
        - - -
        #{@tablero[6]}|#{@tablero[7]}|#{@tablero[8]}
      )
    end

    def putFicha(player, num)
      if @tablero[num - 1] == 'X' || @tablero[num - 1] == 'O'
        return false
      else
        if player == 1
          @tablero[num-1] = 'X'
          return true
        else
          @tablero[num-1] = 'O'
          return true
        end
      end
    end

    def checkEmpate
      if @tablero.all? {|ficha| ficha.is_a? String}
        puts "Los jugadores han empatado"
        return true
      end
    end

    def reiniciar
      @tablero = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end

    def jugador1Name
      @player1.getName
    end

    def jugador2Name
      @player2.getName
    end

    def jugadorStats
      puts @player1
      puts "\n\n\n"
      puts @player2
    end
end

def jugarPartida(tablero)
  ganada = false
  tablero.reiniciar
  jugador = 2
  while ganada==false
    system 'clear'
    if jugador == 2
      jugador = 1
    else
      jugador = 2
    end
      puts tablero
      pusoFicha = false
      while true
        print "#{tablero.jugador1Name} Escribe un numero del 1 al 9: "
        opcion = gets
        pusoFicha = tablero.putFicha(jugador, opcion.to_i)
        if pusoFicha == false
          puts "#{tablero.jugador1Name} La posicion ya esta ocupada"
        else
          if jugador == 1
            ganada = tablero.checkWinP1
          else
            ganada = tablero.checkWinP2
          end
          break
        end
      end
  end
  system "clear"
  puts "============STATS============= \n\n"
  puts tablero.jugadorStats
  puts "============STATS============= \n\n"
  print "¿Quieres jugar otra partida? [s/n]: "

  opcion = gets
  if opcion.chomp == 's'
    jugarPartida(tablero)
  else
    puts "Hasta la proxima"
  end
end

tablero = Tablero.new()
jugarPartida(tablero)
