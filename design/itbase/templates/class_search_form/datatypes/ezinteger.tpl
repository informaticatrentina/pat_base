{* 
    Faccio l'override poiché a priori non conosco i limiti (bounds)
    entro eseguire la ricerca. Utilizzo quindi un campo semplice.
    L'originale si trova in ocsearchtools.
*}

{def $id = concat('search-for-',$input.id)}

<div class="form-group">
    <label for={$id} >{$input.class_attribute.name}</label>
    <input name={$input.name} 
           id={$id} 
           type="numeric" 
           class="form-control" 
           placeholder={$input.class_attribute.name}
           {if ezhttp_hasvariable( $input.name, 'get' )}
             value={ezhttp( $input.name, 'get' )}
           {/if}
           >
</div>

{undef $id}