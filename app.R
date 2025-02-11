library(shiny)
library(shinyjs)
library(shinyWidgets)

# CSS personalizado con animaciones mejoradas
css <- "
@import url('https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&family=Montserrat:wght@300;400;700&display=swap');

body {
  background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
  font-family: 'Montserrat', sans-serif;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 0;
  overflow: hidden;
}

.content {
  text-align: center;
  background: rgba(255, 255, 255, 0.9);
  padding: 40px;
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  max-width: 600px;
  width: 90%;
  position: relative;
  z-index: 10;
}

.floating-heart {
  position: absolute;
  animation: float 6s ease-in-out infinite;
  color: #ff3366;
  font-size: 30px;
  opacity: 0.8;
  z-index: 1;
}

@keyframes float {
  0%, 100% { transform: translateY(0) rotate(0deg); }
  50% { transform: translateY(-20px) rotate(10deg); }
}

.title {
  font-family: 'Dancing Script', cursive;
  font-size: 48px;
  color: #ff3366;
  margin-bottom: 30px;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
}

.subtitle {
  font-size: 24px;
  color: #ff3366;
  margin-bottom: 30px;
}

.button-container {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 30px;
}

.custom-btn {
  padding: 15px 40px;
  font-size: 20px;
  border-radius: 30px;
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
  font-family: 'Montserrat', sans-serif;
  font-weight: bold;
  text-transform: uppercase;
}

.btn-si {
  background-color: #4CAF50;
  color: white;
}

.btn-no {
  background-color: #ff4444;
  color: white;
}

.custom-btn:hover {
  transform: scale(1.05);
  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.poem {
  font-family: 'Dancing Script', cursive;
  font-size: 24px;
  color: #ff3366;
  line-height: 1.6;
  margin-top: 30px;
}

.sad-face {
  font-size: 120px;
  margin: 30px auto;
}

.heart-container {
  position: absolute;
  width: 100%;
  height: 100%;
  overflow: hidden;
  z-index: 0;
}
"

# UI
ui <- fluidPage(
  useShinyjs(),
  tags$head(
    tags$style(css),
    tags$script("
      function createHeart() {
        const heart = document.createElement('div');
        heart.className = 'floating-heart';
        heart.innerHTML = '❤️';
        heart.style.left = Math.random() * 100 + 'vw';
        heart.style.top = Math.random() * 100 + 'vh';
        heart.style.animationDuration = Math.random() * 3 + 3 + 's';
        heart.style.animationDelay = Math.random() * 5 + 's';
        document.querySelector('.heart-container').appendChild(heart);
        setTimeout(() => heart.remove(), 6000);
      }
      
      setInterval(createHeart, 300);
    ")
  ),
  
  div(class = "heart-container"),
  
  # Contenido principal
  div(class = "content",
      # Página inicial
      div(id = "home",
          h1(class = "title", "Mi querida Lyan del Carmen"),
          p(class = "subtitle", "Tengo una pregunta muy especial para ti..."),
          div(class = "button-container",
              actionButton("start", "Descubre la sorpresa", class = "custom-btn btn-si")
          )
      ),
      
      # Página de decisión
      hidden(
        div(id = "decision",
            h1(class = "title", "¿Quieres ser mi San Valentín?"),
            div(class = "button-container",
                actionButton("yes", "Sí", class = "custom-btn btn-si"),
                actionButton("no", "No", class = "custom-btn btn-no")
            )
        )
      ),
      
      # Página del poema
      hidden(
        div(id = "poem",
            h1(class = "title", "¡Te amo con todo mi corazón!"),
            div(class = "poem",
                HTML("En el jardín de mi alma, tú eres la flor más bella,<br>
                     Tu sonrisa, mi sol; tus ojos, mi estrella.<br>
                     Cada instante contigo es un tesoro preciado,<br>
                     Tu amor me hace sentir bendecido y afortunado.<br><br>
                     Gracias por ser mi compañera en esta aventura,<br>
                     Contigo, cada día se llena de dulzura.<br>
                     Te amo más allá de las palabras, más allá del tiempo,<br>
                     Eres mi sueño hecho realidad, mi eterno sentimiento.<br><br>
                     Lyan del Carmen, mi amor por ti es infinito,<br>
                     Juntos, nuestro futuro será exquisito.")
            )
        )
      ),
      
      # Página de rechazo
      hidden(
        div(id = "sad",
            h1(class = "title", "Oh no..."),
            div(class = "sad-face", "😢"),
            p(class = "subtitle", "Tal vez la próxima vez...")
        )
      )
  )
)

# Server
server <- function(input, output, session) {
  observeEvent(input$start, {
    hide("home")
    show("decision")
  })
  
  observeEvent(input$yes, {
    hide("decision")
    show("poem")
  })
  
  observeEvent(input$no, {
    hide("decision")
    show("sad")
  })
}

# Run the app
shinyApp(ui = ui, server = server)