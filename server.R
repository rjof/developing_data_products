#library(shiny)
library(ggplot2)
d <- read.csv("./datasets/atenciones-sf-2014-ene-dic.csv", quote='"',sep=';', header=T )
d <- d[,c(7,8,9,10,13)]
xnac <- aggregate(d$atenciones ~ d$nacionalidad, data=d, sum)
names(xnac) <- c("nac","att")
xnac <- xnac[order(-xnac$att),]
xnac$nac <- factor(xnac$nac, levels=xnac$nac, ordered=T)

shinyServer
(
 function(input, output) {
   output$topX <- renderText({input$topX})
   output$histAtt <- renderPlot({
     xtop <- input$topX
     xnac2 <- reactive({
       xnac[1:xtop,]
     })
     g <- ggplot(data=xnac2())
     g <- g + aes(x=factor(nac), y=att)
     g <- g + geom_bar(stat="identity")
     g <- g + theme(axis.text.x=element_text(angle=90))
     g <- g + xlab("Nacionalidades")
     g <- g + ylab("Number of supervised cases")
     g
   })

   output$pieSex <- renderPlot({
     xtop <- reactive({input$topX})
     nacs = reactive({xnac[1:xtop(),1]})
     forSex = reactive({
       with(d, d[d$nacionalidad %in% nacs(),])
     })
     g <- ggplot(forSex(), aes(x=factor(1), fill=factor(sexo)))
     g <- g + geom_bar(width=1)
     g <- g + coord_polar(theta="y")
     g <- g + xlab("") + ylab("") + labs(fill="Sex")
     g
   })

    output$table <- renderTable({
     xtop <- input$topX
     nacs <- xnac[1:xtop,1]
     forSex <- subset(d, d$nacionalidad %in% nacs)
     forSex
    })

    output$table2 <- renderTable({
      xtop <- input$topX
      xnac <- head(xnac[order(-xnac$att),],xtop)
      xnac
    })
  }
)

