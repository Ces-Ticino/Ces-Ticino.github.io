


tmpdir1="tmpdir/01"
tmpdir2="tmpdir/02"

rm -rf $tmpdir1
rm -rf $tmpdir2

mkdir $tmpdir1
mkdir $tmpdir2
while IFS=, read -r docx thema thema_clean
do
  echo $thema
  pandoc --wrap=none -f docx -t markdown "$docx" -o $tmpdir1/$thema.md
  
  # remove everything up to:
  sed -i '0,/^# /d' $tmpdir1/$thema.md # the first occurance of h1
  sed -i '0,/^# /d' $tmpdir1/$thema.md  # the first occurance of h1
  sed -i '0,/^## /d' $tmpdir1/$thema.md # the first occurance of h2
  
  # remove image tags:
  sed -i '/!\[.*\](.*)/d' $tmpdir1/$thema.md
  # pandoc -f markdown -t markdown --shift-heading-level-by=1 $tmpdir1/$thema.md -o $tmpdir2/$thema.md
  
  # insert title
  sed -i "1i---\ntitle: $thema_clean\n---" $tmpdir1/$thema.md
  
  
  # sed -i -E 's/\((.+\.jpg)\)\s(.+)/![\1](\2)/g' $tmpdir2/$thema.md
  sed -i -E 's/^(.+\.jpg)\s+(.+)/![\2](\/images\/\1)/' $tmpdir1/$thema.md
  
  sed -i -E 's/^(.+\.(jpg|jpeg|png))\s+(.+)/![\3](\/images\/\1)/I' $tmpdir1/$thema.md
  
  # sed -i "/Ces.JPG/d" $tmpdir2/$thema.md
  # sed -i "/Chrysoperla lucasina_Artbeispiel3.jpg/d" $tmpdir2/$thema.md
  # sed -i "/20240713_182804.jpg/d" $tmpdir2/$thema.md
  sed -i "s/Limax_sarnensis_Beispiel2.PNG/Limax sarnensis_Beispiel2.PNG/g" $tmpdir1/$thema.md
  sed -i "s/Xanthoria_elegans_Mermilliod.jpg/Xanthoria_elegans_Mermilliod.JPG/g" $tmpdir1/$thema.md
  sed -i "s/Xanthoria_elegans_Mermilliod.jpg/Xanthoria_elegans_Mermilliod.JPG/g" $tmpdir1/$thema.md
  sed -i "s/Chrysotoxum bicinctum_Artbeispiel2.jpg/Chrysotoxum bicinctum_Artbeispiel2.JPG/g" $tmpdir1/$thema.md
  sed -i "s/Platycheirus albimanus_Artbeispiel3.jpg/Platycheirus albimanus_Artbeispiel3.JPG/g" $tmpdir1/$thema.md
  sed -i "s/Chrysoperla lucasina_Artbeispiel3.jpg/Chrysoperla lucasina_Artbeispiel3.JPG/g" $tmpdir1/$thema.md
  sed -i "s/Panorpa vulgaris_Artbeispiel4.jpg/Panorpa vulgaris_Artbeispiel4.JPG/g" $tmpdir1/$thema.md
  sed -i "s/Chrysotoxum bicinctum_Artbeispiel2.jpg/Chrysotoxum bicinctum_Artbeispiel2.JPG/g" $tmpdir1/$thema.md
  sed -i "s/Platycheirus albimanus_Artbeispiel3.jpg/Platycheirus albimanus_Artbeispiel3.JPG/g" $tmpdir1/$thema.md
  sed -i "s/Chrysoperla lucasina_Artbeispiel3.jpg/Chrysoperla lucasina_Artbeispiel3.JPG/g" $tmpdir1/$thema.md
  sed -i "s/Panorpa vulgaris_Artbeispiel4.jpg/Panorpa vulgaris_Artbeispiel4.JPG/g" $tmpdir1/$thema.md
  
  sed -i "s/Chrysoperla lucasina_Artbeispiel3.JPG/Chrysoperla lucasina_Artbeispiel3.jpg .JPG/g" $tmpdir1/$thema.md
  

  # sed -i "s/Sphagnum_spp_Ces_MM_Md1280.jpg/Sphagnum_spp_Ces_MM.jpg/g" $tmpdir2/$thema.md
  # 
  # sed -i "s/LA_Andrena_fulva_auf Ribesubum_10.5.24_Ces.jpg/LA_Andrena_fulva_auf Ribesrubum_10.5.24_Ces.jpg/g" $tmpdir2/$thema.md
  # 
  
  
done < "docx_df.csv"
