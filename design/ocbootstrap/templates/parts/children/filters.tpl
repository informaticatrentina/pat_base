{set_defaults(hash(
  'page_limit', 10
))}

{def $root_nodes = array( $node.node_id )
     $self = object_handler( $node )}
{if is_set( $self.content_virtual.folder.subtree )}
  {set $root_nodes = $self.content_virtual.folder.subtree}
{/if}

{def $data = class_search_result(  hash( 'subtree_array', $root_nodes,
										 'sort_by', hash( 'name', 'asc' ),
										 'limit', $page_limit ),
								   $view_parameters )}

<div class="row">
  <div class="col-md-8">
	{if and( $data.is_search_request, is_set( $view_parameters.class_id ) )}
	 {include name=class_search_form_result
			  uri='design:parts/class_search_form_result.tpl'
			  data=$data
			  page_url=$node.url_alias
			  view_parameters=$view_parameters
			  page_limit=$page_limit}  
	{else}
	
	 {include uri='design:parts/children/default.tpl' view='line'}
	
	{/if}
  </div>

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
  <div class="col-md-4">
    <div class="widget">
      <div class="widget_title">
        <h3>{"Search"|i18n('design/pat_base/generic')}</h3>
      </div>
      <div class="widget_content">

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
  </div>
  {/if}
</div>