{def $repository_list = repository_list()}

{if count( $repository_list )|gt(0)}
    <header>
        <h2>
            <i class="fa fa-cloud-download"></i>
            Importa contenuti
        </h2>
    </header>
    <hr>
    <p>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Oggetto</th>
                    <th>Sorgente</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
            {foreach $repository_list as $repository}
                <tr>
                    <td>
                        <i class="fa {$repository.Icon}"></i>
                        {$repository.Name}
                    </td>
                    <td>
                        <small>({$repository.Url})</small>
                    </td>
                    <td>
                        <a class="btn btn-primary has_tooltip" 
                           href={concat( 'repository/client/', $repository.Identifier )|ezurl}
                           data-toggle="tooltip"
                           data-placement="top"
                           data-original-title="Cerca e Importa">
                            <i class="fa fa-cloud-download"></i>
                        </a>
                        {if $repository.TematicaSync|eq('true')}
                            <a class="btn btn-success has_tooltip" 
                               href={concat( 'itobjectsync/client/', $repository.Identifier )|ezurl}
                               data-toggle="tooltip"
                               data-placement="top"
                               data-original-title="Import automatico Tematica">
                                <i class="fa fa-tags"></i>
                            </a>
                        {/if}
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </p>
{/if}