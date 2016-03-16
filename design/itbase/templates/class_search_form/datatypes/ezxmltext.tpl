{* 
    Faccio l'override per impostare il valore dal parametro get dopo che è
    già stata lanciata una ricerca
    L'originale si trova in ocsearchtools.
*}                 
                 
{def $id = concat('search-for-',$input.id)}

<div class="form-group">
    <label for={$id} >{$input.class_attribute.name}</label>
    <input name={$input.name} 
           id={$id} 
           type="text" 
           class="form-control" 
           placeholder={$input.class_attribute.name}
           {if ezhttp_hasvariable( $input.name, 'get' )}
             value={ezhttp( $input.name, 'get' )}
           {/if}
           >
</div>

{undef $id}