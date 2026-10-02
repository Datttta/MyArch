#!/bin/sh
set -e

if [ ! -d "target/" ]; then
   echo "Ejecute el script en el directorio padre"
   exit
fi

git fetch origin

if [[ -n "$(git cherry -v 2>/dev/null)" || -n "$(git status --porcelain)" ]]; then
    read -p "Hay cambios sin enviar, desea continuar? [s/n]: " continuar
    if [ "$continuar" != "s" ]; then
       exit 0
    fi
fi

while true; do
   echo "
================ Tipo de actualización ================
1 - Cambios incompatibles
2 - Cambios menores
3 - Corrección de errores o ajustes
0 - Salir

Versión actual: $(awk -F '"' '/^version =/ {print $2}' Cargo.toml)
======================================================
   "

   read -p "Tipo: " actualizacion
   echo ""
  
   case $actualizacion in
      1)
         nueva_version=$(awk -F '"' '/^version =/ { split($2, a, "."); print (a[1]+1) ".0.0" }' Cargo.toml)
         ;;
      2)
         nueva_version=$(awk -F '"' '/^version =/ { split($2, a, "."); print a[1]"." (a[2]+1) ".0" }' Cargo.toml)
         ;;
      3)
         nueva_version=$(awk -F '"' '/^version =/ { split($2, a, "."); print a[1]"." a[2]"." (a[3]+1) }' Cargo.toml)
         ;;
      0)
         exit 0
         ;;
      *)
         echo "Opción inválida"
         continue
         ;;
   esac

   echo "Neuva versión: $nueva_version"
   read -p "Confirmar[s/n]: " confirmar

   if [ "$confirmar" == "s" ]; then
      break
   fi
done

sed -i "s/^version = .*/version = \"$nueva_version\"/" Cargo.toml

echo -e "\nAdicionando cambios en Cargo.toml..."
git add Cargo.toml
echo -e "\nComitting nueava version..."
git commit -m "Release v$nueva_version"
echo -e "\nEnviando cambios..."
git push origin main
echo -e "\nAdicionando tag..."
git tag v$nueva_version
echo -e "\nEnviando tag..."
git push origin v$nueva_version

echo -e "\nConstruindo release..."
cargo build --release
echo -e "\nComprimiendo binario GNU/Linux..."
tar -czf Duetime-x86_64-unknown-linux-gnu.tar.gz -C target/release Duetime
echo -e "\nEnviando versión GNU/Linux..."
gh release create v$nueva_version Duetime-x86_64-unknown-linux-gnu.tar.gz --generate-notes

rm Duetime-x86_64-unknown-linux-gnu.tar.gz

echo -e "\n¡Nueva versión subida a github!"
