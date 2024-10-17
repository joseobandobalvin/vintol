import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vintol/models/infraction.dart';
import 'package:vintol/models/product.dart';
import 'package:vintol/widgets/dialogs.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  //creating the getter
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "vintol.db"),
        onCreate: (db, version) async {
      //create a first table
      await db.execute('''
              CREATE TABLE infractions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                falta TEXT,
                infraccion TEXT,
                calificacion TEXT,
                monto TEXT,
                conDescuento TEXT,
                sancion TEXT,
                puntos TEXT,
                medidaPreventiva TEXT,
                solidario TEXT
              )        
              ''');
    }, version: 1);
  }

  //initial values to database
  Future<void> initialData() async {
    final db = await database;
    int? res = -1;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? infractionsHasData = prefs.getBool('infractionsHasData');

    if (infractionsHasData == null) {
      res = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT COUNT(*) from infractions limit 1
    '''));
    }

    Get.snackbar("Informacion", res.toString());

    if (res! == 0 && infractionsHasData == null) {
      try {
        await prefs.setBool('infractionsHasData', true);
        await db.transaction((txn) async {
          await txn.rawInsert(
            '''
          INSERT INTO infractions (falta, infraccion, calificacion, monto, conDescuento, sancion, puntos, medidaPreventiva, solidario ) 
            VALUES
            ('M01','Conducir con presencia de alcohol en la sangre en proporción mayor a lo previsto en el Código Penal, o bajo los efectos de estupefacientes, narcóticos y/o alucinógenos comprobado con el exámen respectivo o por negarse al mismo y que haya participado en un accidente de tránsito.','Muy Grave','5,150.00','5,150.00','Multa y cancelación de la licencia de conducir e inhabilitación definitiva para obtener licencia','0','Internamiento del Vehiculo y Retencion de la Licencia',' Propietario '),
            ('M02','Conducir con presencia de alcohol en la sangre en proporción mayor a lo previsto en el Código Penal, bajo los efectos de estupefacientes, narcóticos y/o alucinógenos comprobada con el exámen respectivo o por negarse al mismo.','Muy Grave','2,575.00','2,575.00','Multa y suspensión de la licencia de conducir por tres (3) años','0','Internamiento del Vehiculo y Retencion de la Licencia',' Propietario '),
            ('M03','Conducir un vehículo automotor sin tener licencia de conducir o permiso provisional.','Muy Grave','2,575.00','2,575.00','Multa e inhabilitación para obtener licencia de conducir por tres (3) años','0','Internamiento del vehículo',' Propietario '),
            ('M04','Conducir vehículos estando la licencia de conducir retenida, suspendida o estando inhabilitado para obtener licencia de conducir.','Muy Grave','5,150.00','5,150.00','Multa y suspensión de la licencia de conducir por tres (3) años, si ésta estuviese retenida o multa y cancelación definitiva de la licencia de conducir, si la licencia estuviere suspendida','0','Internamiento del Vehiculo y Retencion de la Licencia',''),
            ('M05','Conducir un vehículo con Licencia de Conducir cuya clase o categoría no corresponde al vehículo que conduce.','Muy Grave','2,575.00','2,575.00','Multa y suspensión de la licencia de conducir por un (1) año','70','Retención del vehículo y retención de la licencia de conducir',''),
            ('M06','Estacionar en las curvas, puentes, túneles, zonas estrechas de la vía, pasos a nivel, pasos a desnivel en cambios de rasante, pendientes y cruces de ferrocarril.','Muy Grave','1,236.00','1,236.00','Multa','60','Remoción del vehículo',''),
            ('M07','Participar en competencias de velocidad en eventos no autorizados','Muy Grave','1,236.00','1,236.00','Multa','100','',''),
            ('M08','Permitir a un menor de edad la conducción de un vehículo automotor, sin autorización o permiso provisional.','Muy Grave','1,236.00','1,236.00','Multa','60','Retención del vehículo',' Propietario '),
            ('M09','Conducir un vehículo con cualquiera de sus sistemas de dirección, frenos, suspensión, luces o eléctrico en mal estado, previa inspección técnica vehicular.','Muy Grave','1,236.00','1,236.00','Multa','60','Remoción del vehículo',' Propietario '),
            ('M10','Abastecer de combustible un vehículo del servicio de transporte público de pasajeros con personas a bordo del vehículo.','Muy Grave','618.00','105.06','Multa','50','',' Propietario '),
            ('M11','Conducir vehículos de las categorías M o N sin parachoques o dispositivo antiempotramiento cuando corresponda; o un vehículo de la categoría L5 sin parachoques posterior, conforme a lo establecido en el Reglamento Nacional de Vehículos.','Muy Grave','618.00','105.06','Multa','50','Retención del vehículo',' Propietario '),
            ('M12','No detenerse al aproximarse a un vehículo de transporte escolar debidamente identificado que está recogiendo o dejando escolares.','Muy Grave','618.00','618.00','Multa','50','',''),
            ('M13','Conducir un vehículo con neumático(s), cuya banda de rodadura presente desgaste inferior al establecido en el Reglamento Nacional de Vehículos.','Muy Grave','618.00','105.06','Multa','50','Retención del vehículo',' Propietario '),
            ('M14','No detenerse al llegar a un cruce ferroviario a nivel o reiniciar la marcha sin haber comprobado que no se aproxima tren o vehículo ferroviario, o cruzar la vía ferrea por lugares distintos a los cruces a nivel establecidos.','Muy Grave','618.00','105.06','Multa','50','',''),
            ('M15','Circular produciendo contaminación en un índice superior a los límites máximos permisibles de emisión de gases contaminantes.','Muy Grave','618.00','105.06','Multa','50','Retención del vehículo',' Propietario '),
            ('M16','Circular en sentido contrario al tránsito autorizado','Muy Grave','618.00','618.00','Multa','80','',''),
            ('M17','Cruzar una intersección o girar, estando el semáforo con luz roja y no existiendo la indicación en contrario','Muy Grave','618.00','618.00','Multa','80','',''),
            ('M18','Desobedecer las indicaciones sobre el tránsito que ordene el efectivo de la Policía Nacional del Perú asignado al control del tránsito.','Muy Grave','618.00','105.06','Multa','50','',''),
            ('M19','Conducir vehículos sin cumplir con las restricciones que consigna la Licencia de Conducir.','Muy Grave','618.00','105.06','Multa','50','Retención del vehículo',' Propietario '),
            ('M20a','No respetar el límite máximo o minino de velocidad establecido, de acuerdo a los siguientes supuestos: - a) Superar el límite máximo establecido hasta en 10 km/h adicionales','Muy Grave','927.00','927.00','Multa','50','',''),
            ('M20b','No respetar el límite máximo o minino de velocidad establecido, de acuerdo a los siguientes supuestos: - b) Superar el límite máximo establecido en más de 10 km/h hasta en 30 km/h adicionales','Muy Grave','1,236.00','1,236.00','Multa','60','',''),
            ('M20c','No respetar el límite máximo o minino de velocidad establecido, de acuerdo a los siguientes supuestos: - c) Superar el límite máximo establecido en más de 30 km/h adicionales','Muy Grave','2,575.00','2,575.00','Multa','70','',''),
            ('M20d','No respetar el límite máximo o minino de velocidad establecido, de acuerdo a los siguientes supuestos: - d) No respetar el límite mínimo de velocidad establecido','Muy Grave','927.00','927.00','Multa','50','',''),
            ('M21','Estacionar interrumpiendo totalmente el tránsito','Muy Grave','618.00','618.00','Multa','70','Remoción del vehículo',''),
            ('M22','Detenerse para cargar o descargar mercancías en la calzada y/o en los lugares que puedan constituir un peligro u obstáculo o interrumpan la circulación.','Muy Grave','618.00','105.06','Multa','50','Remoción del vehículo',' Propietario '),
            ('M23','Estacionar o detener el vehículo en el carril de circulación, en carreteras o caminos donde existe berma lateral.','Muy Grave','618.00','618.00','Multa','50','Remoción del vehículo',''),
            ('M24','Circular sin placas de rodaje o sin el permiso correspondiente','Muy Grave','618.00','105.06','Multa','90','Retención del vehículo',' Propietario '),
            ('M25','No dar preferencia de paso a los vehículos de emergencia y vehículos oficiales cuando hagan uso de sus señales audibles y visibles','Muy Grave','618.00','105.06','Multa','90','',''),
            ('M26','Conducir un vehículo especial que no se ajuste a las exigencias reglamentarias sin la autorización correspondiente.','Muy Grave','618.00','105.06','Multa','50','Retención del vehículo',' Propietario '),
            ('M27','Conducir un vehículo que no cuente con el certificado de aprobación de inspección técnica vehicular. Esta infracción no aplica para el caso de los vehiculos L5 de la clasificación vehicular','Muy Grave','2,575.00','2,575.00','Multa','50','Internamiento del vehículo',' Propietario '),
            ('M28','Conducir un vehículo sin contar con la póliza del Seguro Obligatorio de Accidentes de Tránsito, o Certificado de Accidentes de Tránsito, cuando corresponda, o éstos no se encuentre vigente.','Muy Grave','618.00','618.00','Multa','50','Retención del vehículo',' Propietario '),
            ('M29','Deteriorar intencionalmente, adulterar, destruir o sustraer las Placas de exhibición, rotativa o transitoria . ','Muy Grave','618.00','618.00','Multa','50','Retención del vehículo',' Propietario '),
            ('M30','Usar las placas de exhibición, rotativa o transitoria fuera del plazo, horario o ruta establecida o cuando esta ha caducado o ha sido invalidada. ','Muy Grave','618.00','105.06','Multa','50','Retención del vehículo',''),
            ('M31','Utilizar las placas de exhibición, rotativa o transitoria en vehículos a los que no se encuentren asignadas.','Muy Grave','618.00','618.00','Multa','50','Retención del vehículo',' Propietario '),
            ('M33','Circular, conducir u operar máquinas amarillas o verdes por las vías públicas terrestres.','Muy Grave','618.00','105.06','Multa','50','Internamiento',' Propietario '),
            ('M34','Circular produciendo ruidos que superen los límites máximos permisibles.','Muy Grave','618.00','105.06','Multa','50','',' Propietario '),
            ('M35','Voltear en U sobre la misma calzada, en las curvas, puentes, pasos a desnivel, vías expresas, túneles, estructuras elevadas, cima de cuesta, cruce ferroviario a nivel.','Muy Grave','618.00','105.06','Multa','70','',' Propietario '),
            ('M36','Transportar carga sin los dispositivos de sujeción o seguridad establecidos.','Muy Grave','618.00','105.06','Multa','50','Retención del vehículo',' Propietario '),
            ('M37','Conducir y ocasionar un accidente de tránsito con daños personales inobservando las normas de tránsito dispuestas en el presente Reglamento.','Muy Grave','0.00','0.00','Suspensión de la licencia de conducir por un (1) año','70','Internamiento del Vehiculo y Retencion de la Licencia',' Propietario '),
            ('M38','Conducir un vehículo para el servicio de transporte público y ocasionar un accidente de tránsito con daños personales inobservando las normas de tránsito dispuestas por el presente Reglamento.','Muy Grave','0.00','0.00','Suspensión de la licencia de conducir por tres (3) años','0','Internamiento del Vehiculo y Retencion de la Licencia',' Propietario '),
            ('M39','Conducir y ocasionar un accidente de tránsito con lesiones graves o muerte inobservando las normas de tránsito dispuestas en el presente Reglamento.','Muy Grave','0.00','0.00','Cancelación e inhabilitación definitiva del conductor para obtener una licencia de conducir','0','Internamiento del Vehiculo y Retencion de la Licencia',' Propietario '),
            ('M40','Conducir un vehiculo con la licencia de conducir vencida','Muy Grave','257.50','43.78','Multa','0','Retención del vehículo',' Propietario '),
            ('M41','Circular, interrumpir y/o impedir el tránsito, en situaciones de desastre natural o emergencia, incumpliendo las disposiciones de la autoridad competente para la restricción de acceso a las vías.','Muy Grave','7,725.00','1,313.25','Multa','50','Remoción del vehículo',' Propietario '),
            ('M42','Conducir un vehiculo de la categoria L5 de la clasificación vehicular, que no cuente con el certificado de aprobacíón de inspección técnica vehicular','Muy Grave','257.50','257.50','Multa','50','Internamiento del vehículo',' Propietario '),
            ('M43','No respetar el derecho preferente de paso del/de la ciclista o del/ de la conductor/a del VMP','Muy Grave','618.00','105.06','Multa','70','',''),
            ('M44','Obstruir la ciclovía','Muy Grave','618.00','105.06','Multa','70','Retención del vehículo',' Propietario '),
            ('G01','Adelantar o sobrepasar en forma indebida a otro vehículo','Grave','412.00','70.04','Multa','40','',''),
            ('G02','No hacer señales ni tomar las precauciones para girar, voltear en U, pasar de un carril de la calzada a otro o detener el vehículo','Grave','412.00','70.04','Multa','40','',''),
            ('G03','Detener el vehículo bruscamente sin motivo.','Grave','412.00','70.04','Multa','20','',''),
            ('G04','No detenerse antes de la línea de parada, línea de parada adelantada o antes de las áreas de intersección de calzadas o no respetar el derecho de paso del/de la peatón/a o el/la ciclista o del/ de la conductor/a del VMP','Grave','412.00','70.04','Multa','30','',''),
            ('G05','No mantener una distancia suficiente, razonable y prudente, de acuerdo al tipo de vehículo y la vía por la que se conduce, mientras se desplaza o al detenerse detrás de otro.','Grave','412.00','70.04','Multa','20','',''),
            ('G06','No ubicar el vehículo con la debida anticipación en el carril donde va efectuar el giro o volteo.','Grave','412.00','70.04','Multa','20','',''),
            ('G07','No conducir por el carril de extremo derecho de la calzada un vehículo del servicio de transporte público de pasajeros o de carga o de desplazamiento lento o un vehículo automotor menor.','Grave','412.00','70.04','Multa','20','',''),
            ('G08','No utilizar el carril derecho para recoger o dejar pasajeros o carga.','Grave','412.00','70.04','Multa','20','',' Propietario '),
            ('G09','Retroceder, salvo casos indispensables para mantener libre la circulación, para incorporarse a ella o para estacionar el vehículo.','Grave','412.00','70.04','Multa','20','',''),
            ('G10','Incumplir las disposiciones sobre el uso de las vías de tránsito rápido y/o de acceso restringido.','Grave','412.00','70.04','Multa','20','',''),
            ('G11','Circular, estacionar o detenerse sobre una isla de encauzamiento, canalizadora, de refugio o divisoria del tránsito, marcas delimitadoras de carriles, separadores centrales, bermas, aceras, áreas verdes, pasos peatonales, jardines o rampas para minusválidos.','Grave','412.00','70.04','Multa','20','Remoción del vehículo',''),
            ('G12','Girar estando el semáforo con luz roja y flecha verde, sin respetar el derecho preferente de paso de los peatones','Grave','412.00','70.04','Multa','40','',''),
            ('G13','Conducir un vehículo con mayor número de personas al número de asientos señalado en la Tarjeta de Identificación Vehicular, con excepción de niños en brazos en los asientos posteriores; y, llevar pasajeros de pie en vehículos del servicio público de transporte urbano de pasajeros si la altura interior del vehículo es menor a 1.80 metros.','Grave','412.00','70.04','Multa','20','',''),
            ('G14','Tener la puerta, capot o maletera del vehículo abierta, cuando el vehículo está en marcha.','Grave','412.00','70.04','Multa','20','',' Propietario '),
            ('G15','No utilizar las luces intermitentes de emergencia de un vehículo cuando se detiene por razones de fuerza mayor, obstaculizando el tránsito, o no colocar los dispositivos de seguridad reglamentarios cuando el vehículo queda inmovilizado en la vía pública.','Grave','412.00','70.04','Multa','20','',' Propietario '),
            ('G16','Conducir un vehículo por una vía en la cual no está permitida la circulación o sobre mangueras contra incendios','Grave','412.00','70.04','Multa','40','',''),
            ('G17','Conducir vehículos que tengan lunas o vidrios polarizados o acondicionados de modo tal que impidan la visibilidad del interior del vehículo, sin la autorización correspondiente.','Grave','412.00','70.04','Multa','20','Retención del vehículo',' Propietario '),
            ('G18a','Conducir un vehículo sin que ambas manos estén sobre el volante de dirección, excepto cuando es necesario realizar los cambios de velocidad o accionar otros comandos.','Grave','412.00','70.04','Multa','30','',''),
            ('G18b','Conducir un vehículo usando algún dispositivo móvil u objeto portátil que implique dejar de conducir con ambas manos sobre el volante de dirección.','Grave','412.00','70.04','Multa','30','',''),
            ('G19','Conducir un vehículo de la categoría M o N que carezca de vidrios de seguridad reglamentarios o que su parabrisas se encuentre deteriorado, trizado o con objetos impresos, calcomanías, carteles u otros elementos en el área de barrido del limpiaparabrisas y que impidan la visibilidad del conductor o un vehículo de la categoría L5 que contando con parabrisas, micas o similares, tengan objetos impresos, calcomanías, carteles u otros elementos que impidan la visibilidad del conductor. ','Grave','412.00','70.04','Multa','20','Retención del vehículo',' Propietario '),
            ('G20','Conducir un vehículo que no cuenta con las luces o dispositivos retrorreflectivos previstos en los reglamentos pertinentes','Grave','412.00','70.04','Multa','30','Retención del vehículo',' Propietario '),
            ('G21','Conducir un vehículo sin espejos retrovisores.','Grave','412.00','70.04','Multa','20','Retención del vehículo',' Propietario '),
            ('G22','Conducir un vehículo cuando llueve, llovizne o garúe, sin tener operativo el sistema de limpiaparabrisas.','Grave','412.00','70.04','Multa','20','Retención del vehículo',' Propietario '),
            ('G23','Conducir un vehículo del servicio de transporte público urbano de pasajeros con personas de pie, si la altura interior del vehículo no supera a 1,80 metros.','Grave','412.00','70.04','Multa','20','',' Propietario '),
            ('G24','Conducir un vehículo con el motor en punto neutro o apagado.','Grave','412.00','70.04','Multa','20','',' Propietario '),
            ('G25','Conducir un vehículo sin portar el Certificado SOAT físico, excepto que se cuente con certificado electrónico; o sin portar el Certificado contra Accidentes de Tránsito; o que éstos no correspondan al uso del vehículo.','Grave','412.00','70.04','Multa','20','Retención del vehículo',''),
            ('G26','Conducir un vehículo de la categoría M o N con la salida del tubo de escape en la parte lateral derecha, de modo tal que las emisiones o gases sean expulsados hacia la acera por donde circulan los peatones. ','Grave','412.00','70.04','Multa','20','Retención del vehículo',' Propietario '),
            ('G27','Conducir un vehículo cuya carga o pasajeros obstruya la visibilidad de los espejos laterales.','Grave','412.00','70.04','Multa','20','',' Propietario '),
            ('G28','En vehículos de las categorías M y N, no llevar puesto el cinturón de seguridad y/o permitir que los ocupantes del vehículo no lo utilicen, en los casos en que, de acuerdo a las normas vigentes, exista tal obligación. En vehículos automotores de la categoría L5 no contar con cinturones de seguridad para los asientos de los pasajeros o no tener uno o más soportes fijados a su estructura que permitan a los pasajeros asirse de ellos mientras son transportados','Grave','412.00','70.04','Multa','25','',' Propietario '),
            ('G29','Circular en forma desordenada o haciendo maniobras peligrosas','Grave','412.00','70.04','Multa','50','',' Propietario '),
            ('G30','Circular transportando personas en la parte exterior de la carrocería o permitir que sobresalga parte del cuerpo de la(s) personas(s) transportada(s) en el vehículo.','Grave','412.00','70.04','Multa','40','',' Propietario '),
            ('G31a','Circular en las vias publicas urbanas por la noche o cuando la luz natural sea insuficiente o cuando las condiciones de visibilidad sean escasas sin tener encendido el sistema de luces reglamentarias; o circular en la red vial nacional, departamental o regional, sin tener las luces bajas encendidas durante las veinticuatro (24) horas.','Grave','412.00','70.04','Multa','20','',''),
            ('G31b','Circular en las vias publicas terrestres en donde se encuentre instalada la señal vertical informativa ''ZONA DE NEBLINA'' sin tener las luces intermitentes de emergencia encendidas cuando el vehiculo automotor tenga la obligacion de contar con ellas, de acuerdo con lo dispuesto en el Anexo III del RNV.','Grave','412.00','70.04','Multa','20','',''),
            ('G32','Circular por la ciclovía','Grave','412.00','70.04','Multa','50','Remoción del vehículo',' Propietario '),
            ('G33','Circular transportando cargas que sobrepasen las dimensiones de la carrocería o que se encuentren ubicadas fuera de la misma; o transportar materiales sueltos, fluidos u otros sin adoptar las medidas de seguridad que impidan su caída a la vía.','Grave','412.00','70.04','Multa','20','Retención del vehículo',' Propietario '),
            ('G34','Remolcar vehículos sin las medidas de seguridad.','Grave','412.00','70.04','Multa','20','',' Propietario '),
            ('G35','Usar luces altas en vías urbanas o hacer mal uso de las luces.','Grave','412.00','70.04','Multa','20','',' Propietario '),
            ('G36','Compartir el asiento de conducir con otra persona, animal o cosa.','Grave','412.00','70.04','Multa','20','',' Propietario '),
            ('G37','No reducir la velocidad al ingresar a un túnel o cruzar un puente, intersecciones o calles congestionadas, cuando transite por cuestas, cuando se aproxime y tome una curva o cambie de dirección, cuando circule por una vía estrecha o sinuosa, cuando se encuentre con un vehículo que circula en sentido contrario o cuando existan peligros especiales con respecto a los peatones u otros vehículos o por razones del clima o condiciones especiales de la vía.','Grave','412.00','70.04','Multa','20','',''),
            ('G38','Transitar lentamente por el carril de la izquierda, causando congestión o riesgo o rápidamente por el carril de la derecha.','Grave','412.00','70.04','Multa','20','',''),
            ('G39','Aumentar la velocidad cuando es alcanzado por otro vehículo que tiene la intención de sobrepasarlo o adelantarlo.','Grave','412.00','70.04','Multa','20','',''),
            ('G40','Estacionar el vehículo en zonas prohibidas o rigidas señalizadas o sin las señales de seguridad reglamentarias en caso de emergencia.','Grave','412.00','70.04','Multa','25','Remoción del vehículo',''),
            ('G41','Estacionar o detener el vehículo sobre la línea demarcatoria de intersección, dentro de éstas o en el crucero peatonal (paso peatonal)','Grave','412.00','70.04','Multa','40','Remoción del vehículo',''),
            ('G42','Estacionar frente a la entrada o salida de garajes, estacionamientos públicos, vías privadas o en las salidas de salas, espectáculos, centros deportivos en funcionamiento.','Grave','412.00','70.04','Multa','20','Remoción del vehículo',''),
            ('G43','Estacionar a una distancia menor de cinco (5) metros de una bocacalle, de las entradas de hospitales o centros de asistencia médica, cuerpos de bomberos o de hidrantes de servicio contra incendios, salvo los vehículos relacionados a la función del local.','Grave','412.00','70.04','Multa','20','Remoción del vehículo',''),
            ('G44','Estacionar a menos de tres (3) metros de las puertas de establecimientos educacionales, teatros, iglesias y hoteles, salvo los vehículos relacionados a la función del local.','Grave','412.00','70.04','Multa','20','Remoción del vehículo',''),
            ('G45','Estacionar a menos de veinte (20) metros de un cruce ferroviario a nivel.','Grave','412.00','70.04','Multa','20','Remoción del vehículo',''),
            ('G46','Estacionar en zonas no permitidas por la autoridad competente, a menos de diez (10) metros de un cruce peatonal o de un paradero de buses, así como en el propio sitio determinado para la parada del bus.','Grave','412.00','70.04','Multa','20','Remoción del vehículo',''),
            ('G47','Estacionar en lugar que afecte la operatividad del servicio de transporte público de pasajeros o carga o que afecte la seguridad, visibilidad o fluidez del tránsito o impida observar la señalización.','Grave','412.00','70.04','Multa','20','Remoción del vehículo',''),
            ('G48','Estacionar un ómnibus, microbus, casa rodante, camión, remolque, semirremolque, plataforma, tanque, tractocamión, tráiler, volquete o furgón, en en vías públicas de zona urbana, excepto en los lugares que habilite para tal fin la autoridad competente, mediante la señalización pertinente.','Grave','412.00','70.04','Multa','20','Remoción del vehículo',''),
            ('G49','Estacionar un vehículo de categoría M, N u O a una distancia menor a un metro de la parte delantera o posterior de otro ya estacionado, salvo cuando se estacione en diagonal o perpendicular a la vía.','Grave','412.00','70.04','Multa','20','',''),
            ('G50','Estacionar en los terminales o estaciones de ruta, fuera de los estacionamientos externos determinados por la Autoridad competente.','Grave','412.00','70.04','Multa','20','Remoción del vehículo',''),
            ('G51','Estacionar un vehículo automotor por la noche en lugares donde, por la falta de alumbrado público, se impide su visibilidad, o en el día, cuando, por lluvia, llovizna o neblina u otro factor, la visibilidad es escasa, sin mantener encendidas las luces de estacionamiento','Grave','412.00','70.04','Multa','30','Remoción del vehículo',''),
            ('G52','Estacionar un vehículo en vías con pendientes pronunciadas sin asegurar su inmovilización','Grave','412.00','70.04','Multa','40','Remoción del vehículo',''),
            ('G53','Desplazar o empujar un vehículo bien estacionado, con el propósito de ampliar un espacio o tratar de estacionar otro vehículo.','Grave','412.00','70.04','Multa','20','',''),
            ('G54','Abandonar el vehículo en la vía pública.','Grave','412.00','70.04','Multa','20','Internamiento del vehículo',''),
            ('G55','Utilizar la vía pública para efectuar reparaciones, salvo casos de emergencia.','Grave','412.00','70.04','Multa','20','Remoción del vehículo',''),
            ('G56','Recoger o dejar pasajeros fuera de los paraderos de ruta autorizados, cuando existan.','Grave','412.00','70.04','Multa','20','',''),
            ('G57','No respetar las señales que rigen el tránsito, cuyo incumplimiento no se encuentre tipificado en otra infracción. ','Grave','412.00','70.04','Multa','20','',''),
            ('G58','No presentar la Tarjeta de Identificación Vehicular; la Licencia de Conducir, salvo que esta sea electrónica; y/o el Documento Nacional de Identidad o Documento de Identidad, según corresponda','Grave','412.00','70.04','Multa','20','Retención del vehículo',''),
            ('G59','Conducir un vehículo de la categoría L, con excepción de la categoría L5, sin tener puesto el casco de seguridad o anteojos protectores, en caso de no tener parabrisas; o permitir que los demás ocupantes no tengan puesto el casco de seguridad.','Grave','412.00','70.04','Multa','40','Retención del vehículo',' Propietario '),
            ('G60','Circular con placas ilegibles o sin iluminación o que tengan adherido algún material, que impida su lectura a través de medios electrónicos, computarizados u otro tipo de mecanismos tecnológicos que permitan verificar la comisión de las infracciones de tránsito. ','Grave','412.00','70.04','Multa','20','Retención del vehículo',' Propietario '),
            ('G61','No llevar las placas de rodaje en el lugar que corresponde.','Grave','412.00','70.04','Multa','20','Retención del vehículo',''),
            ('G62','Incumplir con devolver las placas de exhibición, rotativa o transitoria dentro de los plazos establecidos en el Reglamento de Placa única Nacional de Rodaje. ','Grave','412.00','70.04','Multa','20','',''),
            ('G63','Utilizar señales audibles o visibles iguales o similares a las que utilizan los vehículos de emergencia o vehículos oficiales.','Grave','412.00','70.04','Multa','20','Retención del vehículo',' Propietario '),
            ('G64','Conducir un vehículo cuyas características registrables o condiciones técnicas han sido modificadas, alteradas o agregadas, atentando contra la seguridad de los usuarios o por no corresponder los datos consignados en la Tarjeta de Identificación Vehicular con los del vehículo.','Grave','412.00','70.04','Multa','20','Retención del vehículo',''),
            ('G65','No ceder el paso a otros vehículos que tienen preferencia.','Grave','412.00','70.04','Multa','20','',''),
            ('G66','Seguir a los vehículos de emergencia y vehículos oficiales para avanzar más rápidamente.','Grave','412.00','70.04','Multa','20','',''),
            ('G70','Detener el vehiculo sobre la demarcación en el pavimento de la señal ''No bloquear cruce'' ','Grave','412.00','70.04','Multa','20','',''),
            ('G71','Circular por las vias públicas terrestres donde se encuentran instaladas garitas o puntos de peaje, sin pagar la tarifa de peaje aprobada por la autoridad competente o el establecido en los contratos de concesión respectivos','Grave','412.00','70.04','Multa','20','',''),
            ('G72a','Utilizar, mientras se conduce el vehículo, cualquier dispositivo electrónico que reproduzca imágenes o videos con fines de entretenimiento visual.','Grave','412.00','70.04','Multa','30','',' Propietario '),
            ('G72b','Utilizar un vehículo que tenga instalados los dispositivos electrónicos permitidos obstaculizando la visibilidad del conductor mientras conduce o las señales emitidas por el tablero de control del vehículo.','Grave','412.00','70.04','Multa','30','',' Propietario '),
            ('G73','Adelantar o sobrepasar a la bicicleta u otros ciclos o al VMP, incumpliendo la obligación de efectuar dicha maniobra por el carril de la izquierda.','Grave','412.00','70.04','Multa','40','',''),
            ('G74','Abrir o dejar abierta la puerta o capot de un vehículo automotor, dificultando la circulación de la bicicleta u otros ciclos o del VMP','Grave','412.00','70.04','Multa','40','',''),
            ('L01','Dejar mal estacionado el vehículo en lugares permitidos.','Leve','206.00','35.02','Multa','5','',''),
            ('L02','Estacionar un vehículo en zonas de parqueo destinadas a vehículos que transportan a personas con discapacidad o conducidos por éstos.','Leve','257.50','43.78','Multa','20','Remoción del vehículo',''),
            ('L04','Abrir o dejar abierta la puerta de un vehículo estacionado, dificultando la circulación vehicular.','Leve','206.00','35.02','Multa','5','',''),
            ('L05','Utilizar el carril de giro a la izquierda para continuar la marcha en cualquier dirección que no sea la específicamente señalada.','Leve','206.00','35.02','Multa','5','',''),
            ('L06','Arrojar, depositar o abandonar objetos o sustancias en la vía pública que dificulten la circulación.','Leve','206.00','35.02','Multa','5','',' Propietario '),
            ('L07','Utilizar la bocina para llamar la atención en forma innecesaria','Leve','206.00','35.02','Multa','10','',' Propietario '),
            ('L08','Hacer uso de bocinas de descarga de aire comprimido en el ámbito urbano.','Leve','206.00','35.02','Multa','5','',' Propietario ');

          ''',
          );
        });
      } catch (e) {
        await prefs.remove('infractionsHasData');
        Get.snackbar("Error", e.toString());
      }
    }
  }

  //read Json
  Future<void> readJson() async {
    final String response = await rootBundle.loadString("assets/data.json");
    final data = await json.decode(response);

    final items = data["items"];
  }

  //write prefs
  Future<void> writePrefs() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('infractionsHasData', true);
  }

  // Close the database
  Future<void> closeDB(database) async {
    await database.close();
  }

  //add new product
  Future<int> addNewProduct(Product p) async {
    final db = await database;

    try {
      var pp = await db.insert("products", p.toMap(),
          conflictAlgorithm: ConflictAlgorithm.rollback);
      return pp;
    } catch (e) {
      return -1;
    }
  }

  //Get all infractions
  Future<List<Infraction>> getInfractions() async {
    final db = await database;

    final res = await db.rawQuery('''
      SELECT * from infractions
    ''');

    return res.map((te) => Infraction.fromMap(te)).toList();
  }

  Future<Product> getById(int id) async {
    final db = await database;

    final res = await db.rawQuery('''
      SELECT * from products WHERE id = ?''', [id]);

    return Product.fromMap(res.first);
  }

  Future<Product> getByBarcode(String barcode) async {
    final db = await database;

    final res = await db.rawQuery('''
      SELECT * from products WHERE barcode = ?''', [barcode]);

    return Product.fromMap(res.first);
  }

  Future<int> update(int id, Product p) async {
    final db = await database;
    return await db.update(
      "products",
      {
        "name": p.name,
        "description": p.description,
        "price": p.price,
        "quantity": p.quantity,
        "barcode": p.barcode
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.rawDelete('''
    DELETE FROM products WHERE id = ?''', [id]);
  }

  Future<Map<dynamic, dynamic>> getDBPath() async {
    String dbPath = await getDatabasesPath();
    // print('================databasePath $dbPath');
    Directory? externalStoragePath = await getExternalStorageDirectory();
    // print('================externalStoragePath $externalStoragePath');
    return {"dbpath": dbPath, "externalstoragepath": externalStoragePath};
  }

  backupDB(BuildContext context) async {
    // var status = await Permission.manageExternalStorage.status;
    // if (!status.isGranted) {
    //   print("====status=========> $status");
    //   await Permission.manageExternalStorage.request();
    // }

    var status1 = await Permission.storage.status;
    // print("======status1=======# $status1");
    if (!status1.isGranted) {
      // print("======status1=======# $status1");
      await Permission.storage.request();
    }
    try {
      File ourDBFile = File(join(await getDatabasesPath(), "vintol.db"));

      Directory? folderPathForDBFile =
          Directory("/storage/emulated/0/StoreDatabase/");
      await folderPathForDBFile.create();
      await ourDBFile.copy("/storage/emulated/0/StoreDatabase/vintol.db");
    } catch (e) {
      // ignore: use_build_context_synchronously
      SnackBars.show(context, error: e.toString());
    }
  }

  restoreDB() async {
    // var status = await Permission.manageExternalStorage.status;
    // if (!status.isGranted) await Permission.manageExternalStorage.request();

    var status1 = await Permission.storage.status;
    if (!status1.isGranted) await Permission.storage.request();

    try {
      File savedDBFile = File("/storage/emulated/0/StoreDatabase/vintol.db");
      await savedDBFile.copy(join(await getDatabasesPath(), "vintol.db"));
    } catch (e) {}
  }

  deleteDB() async {
    try {
      _database = null;
      deleteDatabase(join(await getDatabasesPath(), "vintol.db"));
    } catch (e) {}
  }

  // int? id;
  // String falta;
  // String infraccion;
  // String calificacion;
  // String monto;
  // String conDescuento;
  // String sancion;
  // String puntos;
  // String medidaPreventiva;
  // String solidario;

  Future<List<Infraction>> getDataExample() async {
    var data = <Infraction>[
      Infraction(
        id: 1,
        falta: "M01",
        infraccion:
            "Conducir con presencia de alcohol en la sangre en proporción mayor a lo previsto en el Código Penal, o bajo los efectos de estupefacientes, narcóticos y/o alucinógenos comprobado con el exámen respectivo o por negarse al mismo y que haya participado en un accidente de tránsito.",
        calificacion: "Muy Grave",
        monto: "5,150.00",
        conDescuento: "5,150.00",
        sancion:
            "Multa y cancelación de la licencia de conducir e inhabilitación definitiva para obtener licencia",
        puntos: "0",
        medidaPreventiva:
            "Internamiento del Vehiculo y Retencion de la Licencia",
        solidario: "",
      ),
      Infraction(
        id: 2,
        falta: "M02",
        infraccion:
            "Conducir con presencia de alcohol en la sangre en proporción mayor a lo previsto en el Código Penal, o bajo los efectos de estupefacientes, narcóticos y/o alucinógenos comprobado con el exámen respectivo o por negarse al mismo y que haya participado en un accidente de tránsito.",
        calificacion: "Muy Grave",
        monto: "5,150.00",
        conDescuento: "5,150.00",
        sancion:
            "Multa y cancelación de la licencia de conducir e inhabilitación definitiva para obtener licencia",
        puntos: "0",
        medidaPreventiva:
            "Internamiento del Vehiculo y Retencion de la Licencia",
        solidario: "",
      ),
      Infraction(
        id: 3,
        falta: "M03",
        infraccion:
            "Conducir con presencia de alcohol en la sangre en proporción mayor a lo previsto en el Código Penal, o bajo los efectos de estupefacientes, narcóticos y/o alucinógenos comprobado con el exámen respectivo o por negarse al mismo y que haya participado en un accidente de tránsito.",
        calificacion: "Muy Grave",
        monto: "5,150.00",
        conDescuento: "5,150.00",
        sancion:
            "Multa y cancelación de la licencia de conducir e inhabilitación definitiva para obtener licencia",
        puntos: "0",
        medidaPreventiva:
            "Internamiento del Vehiculo y Retencion de la Licencia",
        solidario: "",
      ),
    ];

    return data;
  }
}
