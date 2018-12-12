{def $currentClass = false()}      
    {if is_set( $self.content_virtual.folder.classes )}
      {def $classes = fetch( 'class', 'list', hash( 'class_filter', $self.content_virtual.folder.classes ) )}
    {else}
      {def $classes = fetch( 'ocbtools', 'children_classes', hash( 'parent_node_id', $node.node_id ) )}
    {/if}

    {if $data.is_search_request}	
      {set $currentClass = cond( is_set( $data.fetch_parameters.class_id ), $data.fetch_parameters.class_id, $classes[0].id )}  
    {elseif count( $classes )|eq(1)}
      {set $currentClass = $classes[0].id}  	
    {/if}

    {if $currentClass|not()}
      {set $currentClass = $classes[0].id}
    {/if}
 
    {if count( $classes )|gt(0)}
        <div class="searchform">
            <div class="row">
                <div class="col-xs-8">
                    <h3>{"search"|i18n('design/pat_base/generic')}</h3>
                </div>
                <div class="col-xs-4 text-right">
                    <span class="fa-stack fa-3x related-icon">
                        <i class="fa fa-circle fa-stack-2x fa-inverse"></i>
                        <i class="fa fa-search fa-stack-1x"></i>
                    </span>
                </div>
            </div>
          <div class="searchform-content">

            {if count( $classes )|gt(1)}
            <ul class="nav nav-tabs" role="tablist">	  
              {foreach $classes as $class}
              <li{if $currentClass|eq( $class.id )} class="active"{/if}><a href="#{$class.identifier}" role="tab" data-toggle="tab">{$class.name|wash()}</a></li>
              {/foreach}	  
            </ul>      
            {/if}

            <div class="tab-content">
              {foreach $classes as $class}             
              <div class="tab-pane{if $currentClass|eq( $class.id )} active{/if}" id="{$class.identifier}">
              {class_search_form( $class.identifier, hash( 'RedirectNodeID', $node.node_id ) )}
              </div>
              {/foreach}
            </div>

          </div>
        </div>
        {literal}
            <script type="text/javascript">
                // Regola posizione dell'icona

                function setSearchFormRelatedIconsMargin(){
                    var parent_width = $(".related-icon").parent().width();
                    var margin = parent_width - 52;

                    $(".related-icon").css("margin-left", margin + "px");
                }

                $( document ).ready( setSearchFormRelatedIconsMargin() );
                // $(window).on('resize', setRelatedIconsMargin() );
            </script>
        {/literal}
    {/if}