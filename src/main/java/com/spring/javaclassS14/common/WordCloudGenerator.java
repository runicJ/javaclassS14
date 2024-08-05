package com.spring.javaclassS14.common;

import com.kennycason.kumo.CollisionMode;
import com.kennycason.kumo.WordCloud;
import com.kennycason.kumo.WordFrequency;
import com.kennycason.kumo.bg.CircleBackground;
import com.kennycason.kumo.font.scale.LinearFontScalar;
import com.kennycason.kumo.nlp.FrequencyAnalyzer;
import com.kennycason.kumo.palette.ColorPalette;

import java.awt.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class WordCloudGenerator {

    public void generateWordCloud(String text, String outputFile) throws IOException {
        FrequencyAnalyzer frequencyAnalyzer = new FrequencyAnalyzer();
        frequencyAnalyzer.setWordFrequenciesToReturn(300);
        frequencyAnalyzer.setMinWordLength(3);

        // String을 공백을 기준으로 단어로 나누어 List로 변환
        List<String> words = Arrays.asList(text.split("\\s+"));

        // 단어 빈도 수 분석
        List<WordFrequency> wordFrequencies = frequencyAnalyzer.load(words);

        Dimension dimension = new Dimension(600, 600);
        WordCloud wordCloud = new WordCloud(dimension, CollisionMode.PIXEL_PERFECT);
        wordCloud.setPadding(2);
        wordCloud.setBackground(new CircleBackground(300));
        wordCloud.setColorPalette(new ColorPalette(Color.RED, Color.GREEN, Color.BLUE, Color.ORANGE));
        wordCloud.setFontScalar(new LinearFontScalar(10, 40));
        wordCloud.build(wordFrequencies);
        wordCloud.writeToFile(outputFile);
    }
}
