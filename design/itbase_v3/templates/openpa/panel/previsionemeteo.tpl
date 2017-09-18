  <!-- start of weather widget -->
                <div class="col-md-6 col-sm-6 col-xs-12">
                  <div class="x_panel">
                    <div class="x_title">
                      <h2>{$node.object.data_map.nome.content}<small> ultimo aggiornamento:
                            
                            {def $dataPublicazione = $node|attribute( 'data_pubblicato' )}
                            {$dataPublicazione.content.timestamp|l10n(date)}
                          </small></h2>
                      
                      <ul class="nav navbar-right panel_toolbox">
                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <!--
                        <li class="dropdown">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                          <ul class="dropdown-menu" role="menu">
                            <li><a href="#">Settings 1</a>
                            </li>
                            <li><a href="#">Settings 2</a>
                            </li>
                          </ul>
                        </li>
                        -->
                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                      </ul>
                      <div class="clearfix"></div>
                    </div>
                    <!-- start of weather day -->
                    {if $node|has_attribute('eventometeo')} 
                       
                        {def $eventometeo =  array()}
                        {foreach $node.data_map.eventometeo.content.relation_list as $relation_item}
                            {set $eventometeo = $eventometeo|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}              
                        {/foreach}
                        
                        {def $eventometeoOggi = $eventometeo[0]}
                        {def $dataOgg = $eventometeoOggi|attribute( 'dataevento' )}
                        
                    {/if}
                     
                    <div class="x_content">
                      <div class="row">
                        <div class="col-sm-12">
                          <div class="temperature"><b>{$dataOgg.content.timestamp|l10n(date)}</b>                            
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-sm-4">
                          <div class="weather-icon">
                            <img src="{$eventometeoOggi.object.data_map.imgtrentino.content}" width="100">
                          </div>
                        </div>
                        <div class="col-sm-8">
                          <div class="weather-text">
                              <h2>Trento <br><i><small>{$node.object.data_map.evoluzionetempo.content}<small></h2>
                          </div>
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="weather-text pull-right">
                          <h3 class="degrees"> {$eventometeoOggi.object.data_map.tempmaxquota.content}  / {$eventometeoOggi.object.data_map.tempmaxvalle.content} °C</h3>
                        </div>
                      </div>

                      <div class="clearfix"></div>
                        <div class="row weather-days">
                        {foreach $eventometeo as $eventometeo_item}
                        <div class="col-sm-2">
                            <div class="daily-weather">
                                <h2 class="day">
                                    {set $dataOgg = $eventometeo_item|attribute( 'dataevento' )}
                                    {$dataOgg.content.timestamp|l10n(date)|extract_left( 3 )} 
                                    </h2>
                                <h3 class="degrees">{$eventometeo_item.object.data_map.tempmaxvalle.content}</h3>
                                <canvas id="clear-day" width="32" height="32"></canvas>
                                <h5>{$eventometeo_item.object.data_map.ventidesc.content}</h5>
                          </div>
                        </div>
                        {/foreach}   
                        <div class="clearfix"></div>
                      </div>
                    </div>
                  </div>

                </div>
                <!-- end of weather widget -->