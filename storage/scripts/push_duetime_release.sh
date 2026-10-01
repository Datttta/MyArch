if [ ! -d "target/" ]; then
   echo "Ejecute el script en el directorio padre"
   exit
fi

while true; do
   echo "
================ Tipo de actualización ================
1 - Cambios incompatibles
2 - Cambios menores
3 - Corrección de errores
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

git add Cargo.toml
git commit -m "Release v$nueva_version"
git tag v$nueva_version
git push origin main
git push origin v$nueva_version

cargo build --release
tar -czf Duetime-x86_64-unknown-linux-gnu.tar.gz -C target/release Duetime
gh release create v$nueva_version Duetime-x86_64-unknown-linux-gnu.tar.gz --generate-notes

rm Duetime-x86_64-unknown-linux-gnu.tar.gz
echo "¡Nueva versión subida a github!"
