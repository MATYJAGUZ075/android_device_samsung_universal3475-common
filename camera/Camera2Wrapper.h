/*
 * Copyright (C) 2017, The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <dlfcn.h>
#include <hardware/camera2.h>

int camera2_device_open(const hw_module_t* module, const char* name, hw_device_t** device);

/*
 * Abre la camara indicada contra el HAL de Samsung y comprueba que el HAL
 * publica parametros utilizables (tamanos de captura y distancia focal).
 * Devuelve 1 si la camara se puede inicializar y 0 si no.
 *
 * Se usa para decidir si la camara frontal se expone al framework: si el
 * HAL no consigue inicializarla (no puede abrir /dev/video102) publica un
 * conjunto de parametros vacio y el framework de Android 13 reventaba al
 * construir las caracteristicas estaticas de esa camara.
 */
int camera2_device_is_usable(const char* id);
