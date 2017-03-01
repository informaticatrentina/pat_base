{def $current_node = fetch( 'content', 'node', hash( 'node_id', $current_node_id ) )}
{def $module_params  = module_params()}

{* Attiva/Disattiva Menù *}
{def $top_menu=true()}

{if $current_node.object.state_identifier_array|contains('top_menu/inactive')}
    {set $top_menu=false()}
{/if}
      

{if $top_menu}
    {def $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )}
    <div id="myNav" class="navbar-default" >
        <div class="container">
            <div class="row">
              <div class="col-md-10">
                <div class="navbar-default collapse navbar-collapse" id="main-navbar">
                 {def $top_menu_class_filter = appini( 'MenuContentSettings', 'TopIdentifierList', array() )
                      $top_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                                'sort_by', $root_node.sort_array,
                                                'class_filter_type', 'include',
                                                'class_filter_array', $top_menu_class_filter ) )
                      $top_menu_items_count = $top_menu_items|count()}

                  {if $top_menu_items_count}
                  <ul class="nav navbar-nav" style="text-transform: uppercase">
                      <li id="node_id_2" class="nav-home-li" >
                          <a href={"/"|ezurl}>
                              <i class="fa fa-home fa-1x"></i>
                          </a>
                      </li>
                    {foreach $top_menu_items as $key => $item}
                        {*$item|attribute('show')*}

                        {if $item.priority|ne(1000)}  
                            {node_view_gui content_node=$item
                                view='nav-main_item'
                                key=$key|sum(1)
                                current_node_id=$current_node_id
                                ui_context=$ui_context
                                pagedata=$pagedata
                                top_menu_items_count=$top_menu_items_count
                                modulename=$module_result.ui_component
                                functionname=$module_params.function_name}
                        {/if}
                    {/foreach}
                  </ul>
                  {/if}
                </div>
              </div>
                <div class="col-md-2">
                    {include uri='design:page_header_searchbox.tpl'}
                </div>
            </div>
        </div>
    </div>
{/if}