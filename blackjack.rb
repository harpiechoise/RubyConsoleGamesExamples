class Player
    def initialize
        @mano = []
    end

    def pasarMano(mano)
        @mano = mano
    end

    def calcularMano
        suma = 0
        aces = []
        no_aces = []
        @mano.each do |carta|
            if carta == 'A'
                aces.push(carta)    
            else
                no_aces.push(carta)
            end
        end    

        no_aces.each do |carta|
            if ['J', 'Q', 'K'].any? {|card| card == carta}
                suma += 10
            else
                suma += carta.to_i
            end
        end

        aces.each do |carta|
            if suma == 10
                suma += 11
            else
                suma += 1
            end
        end

        return suma
    end
    
    def reiniciar
        raise NotImplementedError, 'Este metodo corresponde a la clase Human'
    end

    def addWin
        raise NotImplementedError, 'Este metodo corresponde a la clase Human'
    end

    def addLosses
        raise NotImplementedError, 'Este metodo corresponde a la clase Human'
    end

    def addDineroGanado(dinero)
        raise NotImplementedError, 'Este metodo corresponde a la clase Human'
    end

    def mostrarMano()
        return @mano.map{|n| "[#{n}]"}.join(' ')
    end
end

class Human < Player
    def initialize
        print "Cual es tu nombre: "
        @nombre = STDIN.gets.chomp
        @dinero = 5000
        @wins = 0
        @losses = 0
        @dineroGanado = 0
    end

    def reiniciar
        @dinero = 5000
    end

    def addWin
        @wins += 1
    end

    def addLosses
        @losses += 1
    end

    def addDineroGanado(dinero)
        @dineroGanado += dinero
        @dinero += dinero
    end
    
    def descontarApuesta(dinero)
        @dinero -= dinero
    end

    def to_s 
        %(
            Nombre: #{@nombre}
            Dinero: #{@dinero}
            Veces Ganadas: #{@wins}
            Veces Perdidas: #{@losses}
        )
    end

    def jugadorNombre
        return @nombre
    end

    def entregarCarta(carta)
        @mano.push(carta)
    end
    
    def dinero 
        @dinero
    end
end

class Dealer < Player
    def dealerCheckWin
        puntaje = calcularMano(@mano)
        if puntaje == 21
            return true
        else
            return false
        end
    end    
end

class Mazo
    def initialize
        @cartas = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K','1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K','1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K','1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
    end

    def barajar
        @cartas = @cartas.shuffle
    end

    def sacar
        return @cartas.shift
    end

    def reiniciar
        @cartas = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K','1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K','1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K','1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
    end
end

class Mesa
    def initialize
        @jugador = Human.new
        @dealer = Dealer.new
        @mazo = Mazo.new
        @mazo.barajar
        @apuesta = 0
    end
    def repartir
        manoDealer = [@mazo.sacar, @mazo.sacar]
        @dealer.pasarMano(manoDealer)
        manoJugador = [@mazo.sacar, @mazo.sacar]
        @jugador.pasarMano(manoJugador)
    end

    def mostrarManos
        dealerMano = @dealer.mostrarMano
        puts "Dealer: #{dealerMano[1]} [?]"
        puts "#{@jugador.jugadorNombre}: #{@jugador.mostrarMano}"
        puts "Apostado: #{@apuesta}"
        puts "Dinero: #{@jugador.dinero}"
    end

    def sacarCarta
        @jugador.entregarCarta(@mazo.sacar)
        if @jugador.calcularMano > 21
            @jugador.descontarApuesta(@apuesta)
            return false
        elsif @jugador.calcularMano == 21
            @jugador.dineroGanado(@apuesta)
            return true
        else
            return 0
        end
    end

    def revelarCartas
        puts "Dealer: #{@dealer.mostrarMano} (#{@dealer.calcularMano})"
        puts "#{@jugador.jugadorNombre}: #{@jugador.mostrarMano} (#{@jugador.calcularMano})"
        puts "Apostado: #{@apuesta}"
    end

    def plantarse
        if @jugador.calcularMano > @dealer.calcularMano
            @jugador.addDineroGanado(@apuesta)
            return true
        else
            @jugador.descontarApuesta(@apuesta)
            return false
        end
    end    
    
    def apostar(dinero)
        @apuesta += dinero
    end

    def reiniciar
        @mazo = Mazo.new
        @mazo.barajar
        @apuesta = 0    
    end

    def mostrarJugador
        puts @jugador
    end

    def retornarDinero
        return @jugador.dinero
    end
end

def jugarPartida
    mesa = Mesa.new
    print "Hola estas son tus stats iniciales"
    mesa.mostrarJugador
    puts "[1] Jugar"
    puts "[2] Salir"
    print "Escoge una opcion [1/2]: "
    opcion = STDIN.gets.chomp
    if opcion == "1"
        while true
            system "clear"
            print "Ingresa la cantidad a apostar: "
            apuesta = STDIN.gets.chomp
            if apuesta.to_i > mesa.retornarDinero
                puts apuesta.to_i
                puts "No puedes apostar mas de tu dinero"
            else
                mesa.apostar(apuesta.to_i)
                
            end
            system "clear"
            mesa.repartir
            while true
                mesa.mostrarManos

                puts "[1] Sacar Carta"
                puts "[2] Plantarse"
                print "Escoge una opcion [1/2]"
                opcion = STDIN.gets.chomp

                if opcion == "1"
                    reaccion = mesa.sacarCarta
                    if reaccion == false
                        system "clear"
                        mesa.revelarCartas
                        print "Perdiste, Quieres seguir jugando [s/n]: "
                        opcionR = STDIN.gets.chomp
                        if opcionR == 's'
                            mesa.reiniciar
                            break
                        else
                            break
                        end
                    end
                    if reaccion == true
                        system "clear"
                        mesa.revelarCartas
                        print "Ganaste, quieres seguir jugando [s/n]: "
                        opcionR = STDIN.gets.chomp
                        if opcionR == 's'
                            mesa.reiniciar
                            break
                        else
                            break
                        end
                    end 
                
                elsif opcion == "2"
                    resultado = mesa.plantarse
                    puts "Resultado #{resultado}"
                    if resultado == false
                        #system "clear"
                        mesa.revelarCartas
                        print "Perdiste, Quieres seguir jugando [s/n]: "
                        opcionR = STDIN.gets.chomp
                        if opcionR == 's'
                            mesa.reiniciar
                            break
                        else
                            break
                        end
                    end
                    
                    if resultado == true
                        system "clear"
                        mesa.revelarCartas
                        print "Ganaste, Quieres seguir jugando [s/n]: "
                        opcionR = STDIN.gets.chomp
                        if opcionR == 's'
                            mesa.reiniciar
                            break
                        else
                            break
                        end
                    end
                end
            end
        end
    end
end

jugarPartida