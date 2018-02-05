#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library("data.table")
library(stringr)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
 # term<-input$term
 # output$pred<-pred

  load(file = "full_gram.rda")
  N_Gram_final<-as.data.table(list(Counts,Text,p4)) 
  #colnames(N_Gram_final)<-c("Text","prediction","counts")
  colnames(N_Gram_final)<-c("counts","Text","prediction")
  setkey(N_Gram_final,Text)
  

  
  Pred_Word_F<-unique(N_Gram_final[order(N_Gram_final$counts,decreasing = TRUE),3]  )
  Pred_letter_F<-data.table(prediction="App Initialized",V1=1)
  #Pred_letter_F<-"App loaded"
  pred<-reactive({ 
    term<-input$term
    obs<-input$num1
    #obs=4
    term<-tolower(paste(' ',term, sep=""))
    space_pred<-str_locate_all(pattern =' ', term)
    space_pred<-space_pred[[1]][order(space_pred[[1]][,1],decreasing = TRUE)]
    ## breaking text into words

    if (length(space_pred)>=2 & nchar(term)== 
        space_pred[1])
    {
      term_4<-substr(term,space_pred[4]+1,space_pred[1]-1)
      term_3<-substr(term,space_pred[3]+1,space_pred[1]-1)
      term_2<-substr(term,space_pred[2]+1,space_pred[1]-1)
      
      ##checking in all grams
       Pred_Word_4<-N_Gram_final[term_4,]
      Pred_Word_4<-Pred_Word_4[order(Pred_Word_4$counts,decreasing = TRUE)]
       Pred_Word_4<-na.omit(Pred_Word_4[1:3,])
       
       
       
       Pred_Word_3<-N_Gram_final[term_3,]
       Pred_Word_3<-Pred_Word_3[order(Pred_Word_3$counts,decreasing = TRUE)]
       Pred_Word_3<-na.omit(Pred_Word_3[1:3,])
      
       
      Pred_Word_2<-N_Gram_final[term_2,]
      Pred_Word_2<-Pred_Word_2[order(Pred_Word_2$counts,decreasing = TRUE)]
      Pred_Word_2<-na.omit(Pred_Word_2[1:obs,])
      
      Pred_Word_F<-rbind(Pred_Word_4,Pred_Word_3,Pred_Word_2)        
      Pred_Word_F<-Pred_Word_F[,2:3]
      
      # as.character(Pred_Word_F[1:3,]$Pred)
      
      ##result output
      Pred_letter_F<-Pred_Word_F[1:obs,]
     # as.character(Pred_Word_F[1:3,]$prediction)
      
      
      
      #as.character(term_3)
   # space_pred<-str_locate_all(pattern =' ', term)
    }
    
    if (nchar(term)!= 
        space_pred[1] ) 
    {
      ##print("EM OUT!!!")
      out <- strsplit(as.character(term), split=" ")
      term_last<-out[[1]][(length(out[[1]]))]
      term_last<-paste('^',term_last, sep="")
      Pred_letter_F<-Pred_Word_F[grep(term_last,Pred_Word_F$prediction) ,]
      
      
    }
   
    as.character(Pred_letter_F[1:obs,]$prediction)
   
  })
  
  output$pred<-pred
 # output$pred2<-input$num1
  
})
