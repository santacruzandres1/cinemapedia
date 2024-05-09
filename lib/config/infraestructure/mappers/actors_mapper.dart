import 'package:cinemapedia/config/domain/entities/actors.dart';
import '../models/moviedb/credits_respose.dart';
class ActorsMapper{
//le ponemos cast porque es lo que vamos a etrar de la peticion de la api en esa lista estan los datos del actor, por eso en 'castToEntity' definimos que vamos a recibir un Cast de nuestro model de credits_response.dart. EN este caso es cast, pero podria ser otro *a tener en cuenta*
static Actor castToEntity(Cast cast)=> Actor(
  id: cast.id, 
  name: cast.name, 
  profilePath: cast.profilePath!=null
                ?'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
               :'https://imgs.search.brave.com/YztKBHiTwuboOGO4O6hngpSragDKNRR8Z4UK7oFyjZ8/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pY29u/LWxpYnJhcnkuY29t/L2ltYWdlcy9uby1w/cm9maWxlLXBpYy1p/Y29uL25vLXByb2Zp/bGUtcGljLWljb24t/MjcuanBn'
               ,
  character: cast.character
  );

}