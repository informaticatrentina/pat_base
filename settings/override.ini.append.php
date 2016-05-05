<?php /* #?ini charset="utf-8"?

################################
#           BLOCKS             #
################################

[block_feedback_form]
Source=block/view/view.tpl
MatchFile=block/feedback_form.tpl
Subdir=templates
Match[type]=FeedbackForm
Match[view]=default

[block_carousel]
Source=block/view/view.tpl
MatchFile=block/carousel.tpl
Subdir=templates
Match[type]=Carousel
Match[view]=default

[block_latest_content]
Source=block/view/view.tpl
MatchFile=block/latest_content.tpl
Subdir=templates
Match[type]=LatestContent
Match[view]=default

[block_grid]
Source=block/view/view.tpl
MatchFile=block/grid_1_row_2_columns.tpl
Subdir=templates
Match[type]=Grid
Match[view]=1_row_2_columns

[block_main_story_default]
Source=block/view/view.tpl
MatchFile=block/main_story.tpl
Subdir=templates
Match[type]=MainStory
Match[view]=default

[block_main_story_highlight]
Source=block/view/view.tpl
MatchFile=block/main_story.tpl
Subdir=templates
Match[type]=MainStory
Match[view]=jumbotron

[block_banner]
Source=block/view/view.tpl
MatchFile=block/banner.tpl
Subdir=templates
Match[type]=Banner
Match[view]=default

[block_itemList]
Source=block/view/view.tpl
MatchFile=block/item_list.tpl
Subdir=templates
Match[type]=ItemList
Match[view]=default


# block_gmapitems
# ------------------------------
[block_gmapitems_geo_located_content]
Source=block/view/view.tpl
MatchFile=block/geo_located_content.tpl
Subdir=templates
Match[type]=GMapItems
Match[view]=geo_located_content

[block_gmapitems_geo_located_content_osm]
Source=block/view/view.tpl
MatchFile=block/geo_located_content_osm.tpl
Subdir=templates
Match[type]=GMapItems
Match[view]=geo_located_content_osm

# block_solo_testo
# ------------------------------
[block_solo_testo]
Source=block/view/view.tpl
MatchFile=block/solo_testo.tpl
Subdir=templates
Match[type]=SoloTesto
Match[view]=solo_testo
 * 
 * # block_solo_testo
# ------------------------------
[block_home_menu]
Source=block/view/view.tpl
MatchFile=block/home_menu.tpl
Subdir=templates
Match[type]=HomeMenu
Match[view]=default

# block_in_evidenza
# ------------------------------
[block_in_evidenza]
Source=block/view/view.tpl
MatchFile=block/in_evidenza.tpl
Subdir=templates
Match[type]=InEvidenza
Match[view]=in_evidenza


# block_lista_link
# ------------------------------
[block_lista_link]
Source=block/view/view.tpl
MatchFile=block/lista_link.tpl
Subdir=templates
Match[type]=ListaLink
Match[view]=default


# block_dove_siamo
# ------------------------------
[block_dove_siamo]
Source=block/view/view.tpl
MatchFile=block/dove_siamo.tpl
Subdir=templates
Match[type]=DoveSiamo
Match[view]=default

# block_calendario
# ------------------------------
[block_calendario]
Source=block/view/view.tpl
MatchFile=block/calendario.tpl
Subdir=templates
Match[type]=Calendario
Match[view]=default

# block_lista
# ------------------------------
[block_lista_num]
Source=block/view/view.tpl
MatchFile=block/lista_num.tpl
Subdir=templates
Match[type]=Lista
Match[view]=lista_num

[block_lista_evidenza]
Source=block/view/view.tpl
MatchFile=block/lista_evidenza.tpl
Subdir=templates
Match[type]=Lista
Match[view]=lista_evidenza

[block_lista_accordion]
Source=block/view/view.tpl
MatchFile=block/lista_accordion.tpl
Subdir=templates
Match[type]=Lista
Match[view]=lista_accordion

[block_lista_box]
Source=block/view/view.tpl
MatchFile=block/lista_box.tpl
Subdir=templates
Match[type]=Lista
Match[view]=lista_box

[block_lista_tab]
Source=block/view/view.tpl
MatchFile=block/lista_tab.tpl
Subdir=templates
Match[type]=Lista
Match[view]=lista_tab

[block_lista_carousel]
Source=block/view/view.tpl
MatchFile=block/lista_carousel.tpl
Subdir=templates
Match[type]=Lista
Match[view]=lista_carousel

# block_lista3
# ------------------------------
[block_lista_accordion_Lista3]
Source=block/view/view.tpl
MatchFile=block/lista_accordion_manual.tpl
Subdir=templates
Match[type]=Lista3
Match[view]=lista_accordion_manual

[block_lista_box_2_Lista3]
Source=block/view/view.tpl
MatchFile=block/lista_box2.tpl
Subdir=templates
Match[type]=Lista3
Match[view]=lista_box2

[block_lista_box_3_Lista3]
Source=block/view/view.tpl
MatchFile=block/lista_box3.tpl
Subdir=templates
Match[type]=Lista3
Match[view]=lista_box3

[block_lista_box_4_Lista3]
Source=block/view/view.tpl
MatchFile=block/lista_box4.tpl
Subdir=templates
Match[type]=Lista3
Match[view]=lista_box4

[block_lista_box_5_Lista3]
Source=block/view/view.tpl
MatchFile=block/lista_box5.tpl
Subdir=templates
Match[type]=Lista3
Match[view]=lista_box5

[block_lista_tab_Lista3]
Source=block/view/view.tpl
MatchFile=block/lista_tab.tpl
Subdir=templates
Match[type]=Lista3
Match[view]=lista_tab

[block_lista3_carousel]
Source=block/view/view.tpl
MatchFile=block/lista_carousel.tpl
Subdir=templates
Match[type]=Lista3
Match[view]=lista_carousel

[full_event]
Source=node/view/full.tpl
MatchFile=full/event.tpl
Subdir=templates
Match[class_identifier]=event 

[event_simple]
Source=node/view/full.tpl
MatchFile=full/event.tpl
Subdir=templates
Match[class_identifier]=event_simple


################################
################################ OCBOOSTRAP LINE
################################

[line_decreto]
Source=node/view/line.tpl
MatchFile=line/decreto.tpl
Subdir=templates
Match[class_identifier]=decreto

[line_determinazione]
Source=node/view/line.tpl
MatchFile=line/determinazione.tpl
Subdir=templates
Match[class_identifier]=determinazione

[line_deliberazione]
Source=node/view/line.tpl
MatchFile=line/deliberazione.tpl
Subdir=templates
Match[class_identifier]=deliberazione

[line_struttura_competente]
Source=node/view/line.tpl
MatchFile=line/struttura_competente.tpl
Subdir=templates
Match[class_identifier]=struttura_competente
 
################################
#            FULL              #
################################

[full_web-tv]
Source=node/view/full.tpl
MatchFile=full/web-tv.tpl
Subdir=templates
Match[class_identifier]=folder
Match[section_identifier]=webtv

*/ ?>
