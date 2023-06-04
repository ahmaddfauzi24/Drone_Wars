# Header

header <- dashboardHeader(
  title = "USA Drone Strikes"
)

# Sidebar

sidebar <- dashboardSidebar(
  collapsed = F,
  sidebarMenu(
    menuItem(
      text = "Overview",
      tabName = "Overview",
      icon = icon("dashboard")
    ),
    menuItem(
      text = "Casualties",
      tabName = "Casualties",
      icon = icon("life-ring")
    ),
    menuItem(
      text = "Location",
      tabName = "Location",
      icon = icon("location-crosshairs")
    ),
    menuItem(
      text = "Data",
      tabName = "Data",
      icon = icon("book")
    ),
    menuItem(
      text = "Source", 
      icon = icon("code"),
      href = "https://github.com/ahmaddfauzi24/Drone_Wars"
    )))

# Body

body <- dashboardBody(
  
  # using custom CSS 
  
  tags$head(tags$style(HTML('
                                 /* logo */
                                 .skin-blue .main-header .logo {
                                 background-color: #D2E9E9;
                                 color: black;
                                 font-family: "Georgia";
                                 font-style: bold;
                                 }
  
                                 /* logo when hovered */
                                 .skin-blue .main-header .logo:hover {
                                 background-image: url("usaflag.png") !important;
                                 background-size: cover !important;
                                 border-bottom-color:#E3F4F4;
                                 border-left-color:#E3F4F4;
                                 border-right-color:#E3F4F4;
                                 border-top-color:#E3F4F4;
                                 color: white;
                                 font-family: "Georgia";
                                 font-style: bold;
                                 }
  
                                 /* navbar (rest of the header) */
                                 .skin-blue .main-header .navbar {
                                 background-color: #D2E9E9;
                                 }
  
                                 /* main sidebar */
                                 .skin-blue .main-sidebar {
                                 background-color: #D2E9E9;
                                 font-family: "Gautami";
                                 }
  
                                 /* active selected tab in the sidebarmenu */
                                 .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                                 background-color: #D2E9E9;
                                 border-left-color:#D2E9E9;
                                 color: #5C469C;
                                 font-family: "Georgia";
                                 font-style: italic;
                                 }
  
                                 /* other links in the sidebarmenu */
                                 .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                                 background-color: #E3F4F4;
                                 border-left-color:#E3F4F4;
                                 color: black;
                                 font-family: "Georgia";
                                 font-style: italic;
                                 }
  
                                 /* other links in the sidebarmenu when hovered */
                                 .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                                 background-color: #D2E9E9;
                                 border-left-color:#D2E9E9;
                                 color: #D4ADFC;
                                 font-family: "Georgia";
                                 font-style: italic;
                                 }
                                 /* toggle button when hovered  */
                                 .skin-blue .main-header .navbar .sidebar-toggle:hover{
                                 background-color: black;
                                 border-left-color:#E3F4F4;
                                 }
  
                                 /* body */
                                 .content-wrapper, .right-side {
                                 background-color: #E3F4F4;
                                 font-family: "Georgia";

                                 }
                                 
                                 .box.box-solid.box-primary>.box-header {

                                 }

                                 .box.box-solid.box-primary{
                                 border-bottom-color:#E3F4F4;
                                 border-left-color:#E3F4F4;
                                 border-right-color:#E3F4F4;
                                 border-top-color:#E3F4F4;
                                 background:#E3F4F4;
                                 box-shadow: none;
                                 }
                                 
                                 .box.box-solid.box-danger{
                                 background-image: url("presidentusa.png") !important;
                                 background-size: cover !important;
                                 border-bottom-color:#E3F4F4;
                                 border-left-color:#E3F4F4;
                                 border-right-color:#E3F4F4;
                                 border-top-color:#E3F4F4;
                                 color: white;
                                 box-shadow: none;
                                 }
                                 
                                 .box.box-solid.box-success{
                                 background-image: url("mapp_drone.png") !important;
                                 background-size: cover !important;
                                 border-bottom-color:#E3F4F4;
                                 border-left-color:#E3F4F4;
                                 border-right-color:#E3F4F4;
                                 border-top-color:#E3F4F4;
                                 color: #D4ADFC;
                                 box-shadow: none;
                                 }
                                 
                                 .small-box.bg-black { 
                                 background-color: #5C469C !important;
                                 color: white !important; 
                                 
                                 }
                                 
                                 .small-box.bg-navy { 
                                 background-image: url("bushpres.jpg") !important;
                                 background-size: cover !important;
                                 color: white !important;
                                 
                                 }
                                 
                                 .small-box.bg-red { 
                                 background-image: url("obamapres.jpg") !important;
                                 background-size: cover !important;
                                 color: white !important; 
                                 
                                 }
                                 
                                 .small-box.bg-yellow { 
                                 background-image: url("trumppres.jpg") !important;
                                 background-size: cover !important;
                                 color: white !important; 
                                 
                                 }
                                 
                                 .small-box.bg-green { 
                                 background-color: #D4ADFC !important;
                                 color: white !important;
                                 
                                 }
                                 
                                 .small-box.bg-teal { 
                                 background-color: #D4ADFC !important;
                                 color: white !important; 
                                 
                                 }
                                 
                                 .nav-tabs {
                                 background: #E3F4F4;
                                 border-bottom-color:#E3F4F4;
                                 border-left-color:#E3F4F4;
                                 border-right-color:#E3F4F4;
                                 border-top-color:#E3F4F4;
                                 color: white;
                                 }
                                 
                                 .nav-tabs-custom .nav-tabs li.active:hover a,.nav-tabs-custom .nav-tabs li.active a {
                                 background-color: transparent;
                                 border-color: transparent;
                                 color: #D4ADFC;
                                 
                                 }
                                 
                                 .nav-tabs-custom .nav-tabs li.active {
                                 background-color: white;
                                 border-top-color: #D4ADFC;
                                 border-bottom-color:white;
                                 color:#D4ADFC}
                                 
                                 
  
                               '))),
  
  tabItems(
    
    # TAB 1  
    
    tabItem(
      tabName = "Overview",
      fluidRow(
        fluidPage(
          valueBox(tags$p(strikes_bush$Total, style = "font-size: 100%; color: #D4ADFC;"), 
                   tags$p("Bush Reported Strikes", style = "font-size: 150%; color: white;"),
                   color = "navy",
                   width = 4),
          valueBox(tags$p(comma(strikes_obama$Total), style = "font-size: 100%; color: #D4ADFC;"), 
                   tags$p("Obama Reported Strikes", style = "font-size: 150%; color: white;"),
                   color = "red",
                   width = 4),
          valueBox(tags$p(comma(strikes_trump$Total), style = "font-size: 100%; color: #D4ADFC;"), 
                   tags$p("Trump Reported Strikes", style = "font-size: 150%; color: white;"),
                   color = "yellow",
                   width = 4),
          valueBox(tags$p(paste(round(rate_strikes_bush,3)*100,"%"), style = "font-size: 100%; color: white;"), 
                   tags$p("Civilian Casualties Rate (in Percent)", style = "font-size: 100%; color: white;"),
                   color = "green",
                   width = 4,
                   icon = icon("ribbon")),
          valueBox(tags$p(paste(round(rate_strikes_obama,3)*100,"%"), style = "font-size: 100%; color: white;"), 
                   tags$p("Civilian Casualties Rate (in Percent)", style = "font-size: 100%; color: white;"),
                   color = "green",
                   width = 4,
                   icon = icon("ribbon")),
          valueBox(tags$p(paste(round(rate_strikes_trump,3)*100,"%"), style = "font-size: 100%; color: white;"), 
                   tags$p("Civilian Casualties Rate (in Percent)", style = "font-size: 100%; color: white;"),
                   color = "green",
                   width = 4,
                   icon = icon("ribbon"))
        )
      ),
      
      
      fluidPage(
        div(style = "text-align:center; font-style: italic;", 
            h2("Latar Belakang"
            ),
            h5("By Ahmad Fauzi"
              
            )
        )
      ),
      fluidPage(
        div(style = "text-align:justify", 
            p("Dataset pada Capstone Data Visualization kali ini menggunakan dataset dari Drone Wars. Dimana Database Drone Wars mengumpulkan 
              informasi yang telah dikumpulkan oleh Biro Jurnalisme Investigasi tentang serangan pesawat tak berawak Amerika Serikat di Afghanistan, Pakistan, Somalia, dan Yaman."
            ),
            p("Tentang Database - Biro Jurnalisme Investigasi mengklaim sebagai organisasi nirlaba independen yang berupaya membantu publik lebih memahami dunia melalui jurnalisme 
              investigasi yang mendalam, faktual, tidak terafiliasi secara politik. Namun, perlu dicatat bahwa bidang sayaan mereka membahas masalah keadilan sosial yang condong ke kiri.
              Basis data terdiri dari informasi dari laporan berita, pernyataan, dokumen, siaran pers, gambar, dan video, yang termasuk dalam data bila memungkinkan, baik dari outlet nasional 
              maupun internasional. Sebagian besar data ini berasal dari pelaporan berita. Drone Wars menggunakan empat database terpisah dari The Bureau yakni Afghanistan, Pakistan, Somalia, dan Yaman."
            ),
            p("Salah satu tantangan terhadap perdamaian global adalah meningkatnya insiden terorisme di Timur Tengah, yang telah membuat AS memimpin kampanye kontraterorisme di benua tersebut. 
              Dalam upaya ini, militer AS mengandalkan penggunaan drone atau kendaraan udara tak berawak untuk melawan konflik tersebut. Drone dapat digunakan untuk pengintaian dan pengawasan, serta dilengkapi 
              senjata untuk tujuan militer. Meskipun penggunaan drone telah membawa manfaat seperti kemampuan terbang dalam misi yang lebih lama, biaya yang lebih rendah, dan risiko minimal bagi personel militer, 
              pengoperasian drone juga menuai kontroversi. Penggunaan drone untuk pembunuhan di luar wilayah perang resmi menimbulkan pertanyaan tentang legalitas, akuntabilitas, dan transparansi dalam operasi drone."
            ),
            p("Dalam Proyek Visualisasi Data ini, tujuan data analyst adalah untuk menggambarkan secara jelas dan mudah untuk dipahami mengenai tingkat transparansi yang saya dapatkan dan bagaimana perbedaannya. 
              Berikut ini adalah beberapa contoh sebagai pengantar projek ini:"
            )
            
        )
      ),
      br(),
      fluidRow(
        box(width = 6,
            status = "primary", 
            solidHeader = TRUE,
            echarts4rOutput(outputId = "strikes_pie")
        ),
        box(
          width = 6,
          status = "primary", 
          solidHeader = TRUE,
          echarts4rOutput(outputId = "confirmed_pie")
        )
      ),
      fluidPage(
        div(style = "text-align:justify", 
            p("Anda mungkin menemukan beberapa inkonsistensi dalam laporan yang disajikan dan kumpulan data tersebut. Hal ini disebabkan karena data yang digunakan tidak sepenuhnya resmi. Data tersebut dikumpulkan 
              oleh tim jurnalis Biro dari berbagai sumber seperti laporan berita, pernyataan, dokumen, siaran pers, dan informasi dari pemimpin lokal, dengan beberapa penggabungan dengan data resmi yang dirilis oleh Angkatan Udara AS."
            ),
            p(
              "Perlu dicatat bahwa laporan resmi tentang perkiraan korban drone pertama kali dimulai pada tahun 2016 oleh direktur intelijen nasional pada masa kepresidenan Obama. Namun, serangan drone yang dilaporkan oleh media 
              (berdasarkan dataset saya) telah terjadi di Yaman sejak tahun 2002."
            ),
            p("Inilah mungkin mengapa hanya ada sedikit laporan selama Era Kepresidenan Bush dan tidak ada laporan mengenai serangan yang dikonfirmasi oleh AS di Pakistan. Oleh karena itu, saya berharap bahwa visualisasi dan analisis 
              yang saya berikan dapat membantu menjelaskan transparansi dan memberikan pemahaman yang lebih baik."
              )
          )
      )
    ),
    
    # TAB 2
    tabItem(
      tabName = "Casualties",
      box(width = 6,
          height = 150,
          status = "danger", 
          solidHeader = TRUE,
          align = "center",
          checkboxGroupInput(inputId = "Era",
                             label = h4(tags$b(" ")),
                             choices = unique(drone_strikes$Presidency),
                             selected = levels(drone_strikes$Presidency))
        ),
      fluidPage(
        box(width = 6,
            height = 150,
            status = "success", 
            solidHeader = TRUE,
            align = "center",
            selectInput(inputId = "Country",
                        label = h4(tags$b(" ")),
                        choices = unique(drone_strikes$Country))        
        ),
        valueBoxOutput(width = 4,
                       "total_strikes"),
        valueBoxOutput(width = 4,
                       "inno_death"),
        valueBoxOutput(width = 4,
                       "total.death"),
        box(width = 12,
            status = "primary", 
            solidHeader = TRUE,
            echarts4rOutput(outputId = "timeline_strikes")),
        box(width = 7,
            status = "primary", 
            solidHeader = TRUE,
            plotlyOutput(outputId = "plot_death")),
        box(width = 5,
            status = "primary", 
            solidHeader = TRUE,
            plotlyOutput(outputId = "plot_injured"))
      )
    ),
    
    # TAB 3
    tabItem(
      tabName = "Location",
      fluidPage(
        tabBox(width = 12,
               title = tags$b(" "),
               id = "tabset1",
               side = "left",
               
               tabPanel(tags$b("Pakistan"), 
                        leafletOutput("lm_pks", height = 560)
               ),
               tabPanel(tags$b("Yemen"), 
                        leafletOutput("lm_yemen", height = 560)
               ),
               tabPanel(tags$b("Somalia"), 
                        leafletOutput("lm_soma", height = 560)
               ),
              tabPanel(tags$b("Afghanistan"), 
                        leafletOutput("lm_afg", height = 560)
               )
        )
      ),
      fluidPage(
        div(style = "text-align:center", 
            p("Peta ini telah disesuaikan dengan Intensitas Kejadian Serangan Drone Pada Wilayah Tertentu"))
      ),
      
      
      ),
    
    # TAB 4
    tabItem(
      tabName = "Data",
      h2(tags$b("Dataset"),align = "center",
         style = 'font-family: "Georgia"; font-style: italic;'),
      fluidPage(
        div(style = "text-align:justify", 
            p("Dataset asli terdiri dari 4 dataset yang berbeda dari masing-masing Negara yang tersedia datasetnya, kemudian dataset 
              yang ditampilkan di bawah ini adalah dataset yang sudah data analyst rapihkan menjadi 1 dataset komperhensif agar lebih mudah untuk dipahami, dibaca 
              dan Pre-processing Data. Untuk dataset asli dan proses pembersihan bisa dilihat di halaman 'Source' yang telah disediakan."
            ),
        )
      ),
      DT::dataTableOutput("data_dronewars")
    )
  )
)

#Assembly

ui <- 
  dashboardPage(
    header = header,
    body = body,
    sidebar = sidebar
  )
