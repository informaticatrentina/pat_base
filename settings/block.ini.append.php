<?php /*

[General]
AllowedTypes[]
AllowedTypes[]=Banner
AllowedTypes[]=Calendario
#AllowedTypes[]=Campaign
AllowedTypes[]=Carousel
AllowedTypes[]=DoveSiamo
AllowedTypes[]=FeedbackForm
AllowedTypes[]=FeedReader
AllowedTypes[]=Gallery
AllowedTypes[]=GMapItems
AllowedTypes[]=Grid
AllowedTypes[]=HighlightedItem
AllowedTypes[]=HomeMenu
AllowedTypes[]=InEvidenza
AllowedTypes[]=ItemList
AllowedTypes[]=LatestContent
AllowedTypes[]=Lista
AllowedTypes[]=Lista3
AllowedTypes[]=ListaLink
AllowedTypes[]=MainStory
AllowedTypes[]=Poll
AllowedTypes[]=SoloTesto
AllowedTypes[]=TagCloud
AllowedTypes[]=UpcomingEvents
AllowedTypes[]=Video
AllowedTypes[]=HTML
 
[Carousel]
Name=Carousel
NumberOfValidItems=10
NumberOfArchivedItems=0
ManualAddingOfItems=enabled
ViewList[]
ViewList[]=default
ViewName[default]=Default

[UpcomingEvents]
Name=Prossimi eventi
ManualAddingOfItems=disabled
CustomAttributes[]=node_id
UseBrowseMode[node_id]=true
CustomAttributes[]=number
CustomAttributeNames[number]=Numero di eventi
CustomAttributeTypes[number]=select
CustomAttributeSelection_number[]
CustomAttributeSelection_number[3]=3
CustomAttributeSelection_number[5]=5
CustomAttributeSelection_number[8]=8
CustomAttributeSelection_number[10]=10
ViewList[]
ViewList[]=default
ViewName[default]=Lista

[LatestContent]
Name=Ultimi contenuti
ManualAddingOfItems=disabled
CustomAttributes[]=parent_node_id
UseBrowseMode[parent_node_id]=true
CustomAttributes[]=class
CustomAttributes[]=limit
CustomAttributes[]=offset
ViewList[]
ViewList[]=default
ViewName[]
ViewName[default]=Default

[Grid]
Name=Griglia
NumberOfValidItems=6
NumberOfArchivedItems=6
ManualAddingOfItems=enabled
ViewList[]
ViewList[]=1_row_2_columns
ViewList[]=1_row_3_columns
ViewList[]=2_rows_2_column
ViewList[]=2_rows_3_columns
ViewName[1_row_2_columns]=1 riga 2 colonne
ViewName[1_row_3_columns]=1 riga 3 colonne
ViewName[2_rows_2_column]=2 righe 2 colonne
ViewName[2_rows_3_columns]=2 righe 3 colonne

[Banner]
Name=Banner
NumberOfValidItems=4
NumberOfArchivedItems=0
ManualAddingOfItems=enabled
ViewList[]
ViewList[]=default
ViewName[default]=Default

#---------------------------------------------#
#   eZ Demo
#---------------------------------------------#

[Campaign]
Name=Campaign
NumberOfValidItems=5
NumberOfArchivedItems=5
ManualAddingOfItems=enabled
ViewList[]
ViewList[]=default
ViewName[default]=Default

[MainStory]
Name=Main story
NumberOfValidItems=1
NumberOfArchivedItems=5
ManualAddingOfItems=enabled
CustomAttributes[]=hide_title
CustomAttributeNames[hide_title]=Nascondi il titolo del contenuto
CustomAttributeTypes[hide_title]=checkbox
ViewList[]=default
ViewList[]=jumbotron
ViewName[default]=Default
ViewName[jumbotron]=Highlight

#[ContentGrid]
#Name=Content Grid
#NumberOfValidItems=8
#NumberOfArchivedItems=8
#ManualAddingOfItems=enabled
#ViewList[]
#ViewList[]=default
#ViewList[]=1_column_4_rows
#ViewList[]=2_columns_2_rows
#ViewList[]=3_columns_1_row
#ViewList[]=3_columns_2_rows
#ViewList[]=4_columns_1_row
#ViewList[]=4_columns_2_rows
#ViewName[default]=1 column 2 rows
#ViewName[1_column_4_rows]=1 column 4 rows
#ViewName[2_columns_2_rows]=2 columns 2 rows
#ViewName[3_columns_1_row]=3 columns 1 row
#ViewName[3_columns_2_rows]=3 columns 2 rows
#ViewName[4_columns_1_row]=4 columns 1 row
#ViewName[4_columns_2_rows]=4 columns 2 rows

[Gallery]
Name=Gallery
NumberOfValidItems=8
NumberOfArchivedItems=5
ManualAddingOfItems=enabled
ViewList[]
ViewList[]=default
ViewName[default]=Default

#[Banner]
#Name=Banner
#NumberOfValidItems=1
#NumberOfArchivedItems=5
#ManualAddingOfItems=disabled
#CustomAttributes[]
#CustomAttributes[]=image_node_id
#CustomAttributes[]=url
#CustomAttributes[]=path
#CustomAttributes[]=code
#CustomAttributeTypes[code]=text
#CustomAttributeNames[url]=Target URL
#CustomAttributeNames[path]=Image path
#CustomAttributeNames[code]=JavaScript / XHTML code
#UseBrowseMode[image_node_id]=true
#ViewList[]
#ViewList[]=default
#ViewList[]=external
#ViewList[]=code
#ViewName[default]=Internal
#ViewName[external]=External
#ViewName[code]=Code

[Video]
Name=Video
NumberOfValidItems=1
NumberOfArchivedItems=5
ManualAddingOfItems=enabled
ViewList[]
ViewList[]=default
ViewName[default]=Default

[TagCloud]
Name=Tag cloud
ManualAddingOfItems=disabled
CustomAttributes[]
CustomAttributes[]=subtree_node_id
UseBrowseMode[subtree_node_id]=true
ViewList[]
ViewList[]=default
ViewName[default]=Default

[Poll]
Name=Poll
ManualAddingOfItems=disabled
CustomAttributes[]
CustomAttributes[]=poll_node_id
UseBrowseMode[poll_node_id]=true
ViewList[]
ViewList[]=default
ViewName[default]=Default

[ItemList]
Name=Item list
NumberOfValidItems=12
NumberOfArchivedItems=5
ViewList[]
ViewList[]=default
ViewName[default]=Default
ManualAddingOfItems=enabled
CustomAttributes[]=number
CustomAttributeNames[number]=Mostra data Pubblicazione
CustomAttributeTypes[number]=select
CustomAttributeSelection_number[]
CustomAttributeSelection_number[0]=SI
CustomAttributeSelection_number[1]=NO


  
 
[FeedReader]
Name=Feed reader
ManualAddingOfItems=disabled
CustomAttributes[]
CustomAttributes[]=source
CustomAttributes[]=limit
CustomAttributes[]=offset
ViewList[]
ViewList[]=default
ViewName[default]=Default

[FeedbackForm]
Name=Feedback Form
NumberOfValidItems=1
NumberOfArchivedItems=5
ManualAddingOfItems=enabled
ViewList[]
ViewList[]=default
ViewName[default]=Default

[HighlightedItem]
Name=Highlighted Item
NumberOfValidItems=1
NumberOfArchivedItems=5
ManualAddingOfItems=enabled
ViewList[]
ViewList[]=default
ViewName[default]=Default

[SoloTesto]
Name=Solo Testo (assegnare una cartella)
NumberOfValidItems=1
NumberOfArchivedItems=0
CustomAttributes[]=node_id
CustomAttributes[]=title_size
CustomAttributes[]=select_true_false
CustomAttributeNames[node_id]=Cartella
CustomAttributeNames[title_size]=Dimensione Titolo (1,2,3,4)
CustomAttributeNames[select_true_false]=Mostra pulsante "Visualizza titolo del blocco "
CustomAttributeTypes[select_true_false]=select_true_false
CustomAttributeTypes[title_size]=title_size

UseBrowseMode[node_id]=true
ManualAddingOfItems=disabled
ViewList[]
ViewList[]=solo_testo
ViewName[]
ViewName[solo_testo]=Solo Testo

[ListaLink]
Name=Lista di Link (assegnare una cartella)
NumberOfValidItems=1
NumberOfArchivedItems=0
CustomAttributes[]=node_id
UseBrowseMode[node_id]=true
ManualAddingOfItems=disabled
ViewList[]
ViewList[]=default
ViewName[]
ViewName[default]=Default

[Calendario]
Name=Calendario (assegnare una calendario eventi)
NumberOfValidItems=1
NumberOfArchivedItems=0
CustomAttributes[]=node_id
UseBrowseMode[node_id]=true
ManualAddingOfItems=disabled
ViewList[]
ViewList[]=default
ViewName[]
ViewName[default]=Default

[InEvidenza]
Name=InEvidenza (assegnare una directory News)
NumberOfValidItems=1
NumberOfArchivedItems=0
CustomAttributes[]=node_id
UseBrowseMode[node_id]=true
ManualAddingOfItems=disabled
ViewList[]
ViewList[]=in_evidenza
ViewName[]
ViewName[in_evidenza]=In Evidenza

[DoveSiamo]
Name=Dove Siamo (parametri presi dalla home)
NumberOfValidItems=0
NumberOfArchivedItems=0
CustomAttributes[]=note
ManualAddingOfItems=disabled
ViewList[]
ViewList[]=default
ViewName[]
ViewName[default]=Default

[Lista]
Name=Lista di oggetti (assegnare un contenitore)
NumberOfValidItems=1
NumberOfArchivedItems=0
CustomAttributes[]=node_id
UseBrowseMode[node_id]=true
CustomAttributes[]=livello_profondita
CustomAttributes[]=limite
CustomAttributes[]=includi_classi
CustomAttributes[]=escludi_classi
CustomAttributes[]=ordinamento
CustomAttributes[]=columns
CustomAttributes[]=state_id
CustomAttributes[]=show_all_btn
CustomAttributes[]=bg_color
  
CustomAttributeNames[]
CustomAttributeNames[livello_profondita]=Livello di profondità nell'alberatura
CustomAttributeNames[limite]=Numero di elementi
CustomAttributeNames[includi_classi]=Tipologie di contenuto da includere
CustomAttributeNames[escludi_classi]=Tipologie di contenuto da escludere (alternativo rispetto al precedente)
CustomAttributeNames[ordinamento]=Ordina per
CustomAttributeNames[columns]=Numero di Colonne
CustomAttributeNames[state_id]=Stato
CustomAttributeNames[show_all_btn]=Mostra pulsante "Visualizza Tutti..." (SI/NO)
CustomAttributeNames[bg_color]=Colore di sfondo (es.  #e4e4e4)
 
CustomAttributeTypes[ordinamento]=select
CustomAttributeTypes[state_id]=state_select
CustomAttributeSelection_ordinamento[]
CustomAttributeSelection_ordinamento[name]=Titolo
CustomAttributeSelection_ordinamento[published]=Data di pubblicazione
CustomAttributeSelection_ordinamento[modified]=Data di ultima modifica
CustomAttributeSelection_ordinamento[priority]=Priorità del nodo

ManualAddingOfItems=disabled
 *
ViewList[]
ViewList[]=lista_num
ViewList[]=lista_num_responsive
#ViewList[]=lista_box
ViewList[]=lista_carousel
ViewList[]=lista_evidenza
ViewName[]
ViewName[lista_num]=Pannelli (carousel)
ViewName[lista_num_responsive]=Panelli con foto responsiva (carousel)
ViewName[lista_carousel]=Banner (carousel)
ViewName[lista_evidenza]=Pannelli in evidenza (carousel)
TTL=3600

[Lista3]
Name=Lista di oggetti (assegnati singolarmente) - MAX 5
NumberOfValidItems=5
NumberOfArchivedItems=0
ManualAddingOfItems=enabled
CustomAttributes[]=limit
CustomAttributeNames[limit]=Limite oggetti da visualizzare (Solo per Schede)
ViewList[]
ViewList[]=lista_accordion_manual
ViewList[]=lista_carousel
ViewList[]=lista_box2
ViewList[]=lista_box4
ViewList[]=lista_tab
ViewName[]
ViewName[lista_accordion_manual]=Pannelli (TODO)
ViewName[lista_carousel]=Banner (carousel)
ViewName[lista_box2]=Box a 3 colonne (3 oggetti) (TODO)
ViewName[lista_box4]=Box ultimi figli (3 oggetti) (TODO)
ViewName[lista_tab]=Schede (tab)

[GMapItems]
Name=Google Map Items
ManualAddingOfItems=disabled
CustomAttributes[]=parent_node_id
CustomAttributes[]=class
CustomAttributes[]=attribute
CustomAttributes[]=limit
CustomAttributes[]=width
CustomAttributes[]=height
UseBrowseMode[parent_node_id]=true
ViewList[]=geo_located_content
ViewList[]=geo_located_content_osm
ViewName[geo_located_content]=Geo-Located Content (Google Map)
ViewName[geo_located_content_osm]=Geo-Located Content (Open Layers)
        
[HomeMenu]
Name=Menu Homepage
NumberOfValidItems=10
NumberOfArchivedItems=5
ManualAddingOfItems=enabled
ViewList[]
ViewList[]=default
ViewName[default]=Default

[HTML]
Name=Codice HTML
ManualAddingOfItems=disabled
CustomAttributes[]
CustomAttributes[]=html
CustomAttributeTypes[html]=text
ViewList[]
ViewList[]=html
ViewName[html]=html
 
*/ ?>
