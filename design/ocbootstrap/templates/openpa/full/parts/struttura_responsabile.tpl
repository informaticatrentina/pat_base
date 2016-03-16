{def $roles = fetch( 'openpa', 'ruoli', hash( 'struttura_object_id', $struttura.contentobject_id ) )}    
{if or( $roles|count(), and( is_set( $struttura.data_map.responsabile ), $struttura.data_map.responsabile.has_content ) )}    
    {if $roles|count()}
        {foreach $roles as $item}
        <div class="row attribute-responsabile">
          <div class="col-md-3"><strong>{$item.name|wash()}</strong></div>
          <div class="col-md-9">
              <a href= {$item.url_alias|ezurl()}>
                  {attribute_view_gui attribute=$item.data_map.utente}
              </a>					
          </div>
        </div>
        {/foreach}
        
    {elseif and( is_set( $struttura.data_map.responsabile ), $struttura.data_map.responsabile.has_content )}
        <div class="row attribute-responsabile">
          <div class="col-md-2"><strong>{$struttura.data_map.responsabile.contentclass_attribute_name}</strong></div>
          <div class="col-md-10">
          {if $struttura.data_map.responsabile.has_content}
              {attribute_view_gui attribute=$struttura.data_map.responsabile}
          {/if}
          </div>
        </div>
    {/if}    
{/if}
{undef $roles}